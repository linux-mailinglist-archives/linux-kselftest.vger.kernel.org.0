Return-Path: <linux-kselftest+bounces-14710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3A945EBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BF51C21214
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719F1DD38A;
	Fri,  2 Aug 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="CGXWxzQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497911E867
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605517; cv=none; b=vBUSyz/BFgGE0qt+j30aP/g46T55TWsm9swM+UEnItATCjSBaaGwUelntPwS2kJqhzR2rrUMnwlh2Pi9dW8U/xV2XTdnFRvJm4cxtoR4zSidTi2EYsAaLqmyvvF1lnTl/toK2054Lw9yeZhDmoV8w19xiLeoBptFn9QQ4ob8Dnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605517; c=relaxed/simple;
	bh=y868V0BKdM8KLdinrQrOwRisn0VO2bjoIX+yOg+jX9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9ZUOA1zOg6eIRhKC8zHw3TzobZzt45cuOGfuM3jNcinRLlv2c7DGhBpPca+7DBW/piOiVWYP5NFkN/S8080vN57wxbwi0W0JDwM/TmU5uY+k3X7aKbomNCXY9HaY7QzpFwKiYd8+TK1gjBtOKDQXovM1iWd8n/7t90AAcgfQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=CGXWxzQX; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 6E2901111B36;
	Fri,  2 Aug 2024 16:25:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 6E2901111B36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1722605111; bh=y868V0BKdM8KLdinrQrOwRisn0VO2bjoIX+yOg+jX9w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=CGXWxzQXh6JSADZhUabUxUrwBnzHIwcoMM3wQqBAYd0bN+kGIA4cMqDN6ShuAKqDk
	 I1LHClbWRLlZhnluv0ZWgU++TQArdUU4OlGpB43f+c4WwfWyPnW/xjEf4/gbqiX1Bt
	 YdhzPLJo7bdT7U893e7LCFsVy2GOhRxYXCnLz0Ps=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 6C18F313A9EA;
	Fri,  2 Aug 2024 16:25:11 +0300 (MSK)
From: Khannanov Lenar <Lenar.Khannanov@infotecs.ru>
To: "dcaratti@redhat.com" <dcaratti@redhat.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pshelar@ovn.org" <pshelar@ovn.org>, Gavrilov Ilia
	<Ilia.Gavrilov@infotecs.ru>
Subject: Questions regarding "act_mirred: use the backlog for nested calls to
 mirred ingress"
Thread-Topic: Questions regarding "act_mirred: use the backlog for nested
 calls to mirred ingress"
Thread-Index: AQHa5N9mRD4kWmu1A0KbEKNPYudL0g==
Date: Fri, 2 Aug 2024 13:25:10 +0000
Message-ID: <538c83e8-ee22-46e0-8c7e-979b217b8598@infotecs.ru>
References: <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
In-Reply-To: <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D15B7BC6799604185745A619F616D44@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/08/02 12:46:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/08/02 10:49:00 #26209077
X-KLMS-AntiVirus-Status: Clean, skipped

SGVsbG8gRGF2aWRlLA0KDQpJbiB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCg0KY29tbWl0IGNhMjJk
YTJmYmQ2OTNiNTRkYzhlM2I3YjU0Y2NjOWY3ZTliYTM2NDANCkF1dGhvcjogRGF2aWRlIENhcmF0
dGkgPGRjYXJhdHRpQHJlZGhhdC5jb20+DQpEYXRlOsKgwqAgRnJpIEphbiAyMCAxODowMTo0MCAy
MDIzICswMTAwDQoNCsKgwqDCoCBhY3RfbWlycmVkOiB1c2UgdGhlIGJhY2tsb2cgZm9yIG5lc3Rl
ZCBjYWxscyB0byBtaXJyZWQgaW5ncmVzcw0KDQp5b3UgYWRkZWQgdGhlIG1pcnJlZF9lZ3Jlc3Nf
dG9faW5ncmVzc190Y3BfdGVzdCBrc2VsZnRlc3QgdGhhdCwgSSBub3RpY2VkLCBoYW5ncyB3aXRo
ICJOY2F0OiBUSU1FT1VULiIgaWYgb3BlbnZzd2l0Y2ggbW9kdWxlIGlzIGxvYWRlZC4NCg0KSXMg
dGhpcyB0aGUgcmlnaHQgYmVoYXZpb3VyIG9yIHdhcyBzdWNoIGNvbmZpZ3VyYXRpb24gbm90IGlu
dGVuZGVkPw0KDQpSZWdhcmRzLA0KTGVuYXIgS2hhbm5hbm92DQo=

