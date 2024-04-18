Return-Path: <linux-kselftest+bounces-8339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F38A9DD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6041C2198D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3216ABC0;
	Thu, 18 Apr 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="p5Dfm7D6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB9433BF;
	Thu, 18 Apr 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452456; cv=none; b=MX6gMeEMz+BeJRMSmi5h190ByPdWspZrJevSFU0wrrMAza66zHkVJKajfsLyW98oA9Ffr/oRiiP71ajracgvLlMNZiR2i9SEo210TakvbT9odvMmZzdOMkk2x+U2M+v55AAmp8VicLrDje73YHkRA9EFfCEBVp6gGyn5NaB3PxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452456; c=relaxed/simple;
	bh=2ZW/FZ3LOYDS3w3KGCimfYqRztdugr0FidbJ2WNUZAw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=THHy28WDfKtFpcfNOPQTMtwbjXYo9E2uhTYcwKCZia50GKCrO6TVONlqlCb2sps2jA+U7iOfjj/EmZypMw0i6Tmnxu3PDFyFRwZCFyk+bGhRxvxza3wLqpfYMI6e2Clojgj0sU5ndn4Tra+TY/SsNettwflQ1Vhad2vWfeooYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=p5Dfm7D6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713452436; x=1714057236; i=markus.elfring@web.de;
	bh=2ZW/FZ3LOYDS3w3KGCimfYqRztdugr0FidbJ2WNUZAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p5Dfm7D6SZwfH5wf9JB2c4KNQARwrMwTYL+iXeqAmXkLz3zphYOA7g74phSTnBV+
	 1Wyy9Vrq8YYLEwUjicFT49xcu/XwfiP4gmZoJaaKuXmYBTqLIfdOGv9PAhQRoZyTk
	 tf3uB9RgnIxutRVQ+yq3Torq1iux3EDbipsw/qh6FbbLxweOLKV5iqdg8AV3YjSto
	 IWBcwlNdBJ5z4MYJUxdIf0UgW8HAB8doT/rorNDSxigPqo8Y9dp231w8vwkvGoFoe
	 m820XYjl+IZvjj3N/z/c5yT+qTmtv9QRQ2kBn4isjizDrol5L6f4+2FROM7Ld2l8g
	 QxvL4Kpv4iOV/cf+2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1sJnUN2vAJ-00OV5y; Thu, 18
 Apr 2024 17:00:36 +0200
Message-ID: <b96697ff-3177-4559-a410-104ca3a1110f@web.de>
Date: Thu, 18 Apr 2024 17:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240418131754.58217-2-wander@redhat.com>
Subject: Re: [PATCH 1/2] kunit: unregister the device on error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240418131754.58217-2-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LoYR5OOkNO1IMk0/llpub1AYS06M9QEB/iRygIyFAo8pg5Sd5HB
 cR3k/yJzI4bdUwtbFDI0041CcL+esda5DOoi53UItLnGW3Au1QPRL5R4EGUFU3Kx0bkLDk8
 F4LX6kGJI24gAnvfeDbP4/yURGmTWuTq8aYcFmHTuOc44iIii03lYr7bpKezHsgA6YPpMif
 P2+EPliUoupjZbJDcagzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FUEOxYAIpJ8=;aRIxn8r1lavSmvU+iyLodHt+x1Y
 me99TOMMRVlJsgPI2fqMpf5R2ss6vpa/+Zg88ZQxIrtU5ah2S9wTrDh0uvmPmpBLOTBrT66ZT
 lg1rDe6MdbyT5/dIBuwyaQUwycUm7HyIJ3MjmBMhL8kUK2GWwNYP89YaGsgT6Eoio7ZEVlXvN
 Nc6S9aSTOPXYjvMV3+H0OGHIFQIRfVfPN2TM6257Na6O60J4P4bxaCqvocETdrBzzBs/0fU4V
 HK1JK/kmDXkFh1q3GMcVCtDED0YDjxZA7z4FR0pg/0SJV1zNouRW/5EIy/KoZvkvwqb48H0Ud
 9SXU1U1dEq1bhT3TbO9a8HIloESg/0AOYKO0nN1OAYiI6YVrq/5Yvw4TY+z9MPiLyYVpL71FH
 Ai7PgpLcusdbvgrLDmX344E/H4u+KbldP9ZHmNCMalw8xUIm3U8tssJIJRikwPERJmX52cOIL
 ccNHz2oRNAzFzly8TqU3rtOV6ftDqSVMogsnkRlTizEl6RCRSD7MyLFgjALwN7UqggmGHWv0Q
 6U25RUUp0Twsaci3Oi3me3Wt3jI5z/Vaqc4NE898yinRkiisp3X/kH8x70vSuq+fGVZFC/VMR
 oQnApURhLsw2kwp1k3zYTostkcwZa4qe7Gi6f8fhAFmL8pzp9Kulji2uBDvlESPvhb0+77h1z
 Ktn1WwzO612MKS7RC0rv4pqImahhRNc+oo8UH0r7FmUfjor320br87rhgYSk73Pq7o2efKpUe
 wSsOFfz8OrQrkPcChhhqapxy452PauwhfRTAyd/7Wh8Iy2OgiOfMsWqQ+PUp9ePCflqjRbgTD
 7IwBeFQro85/HnbmFXZG0zVNwQqFwiycpZGWaL0YLfDu8=

> kunit_init_device() should unregister the device on bus register error.

* Would another imperative wording be desirable also for this change descr=
iption?

* Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

Regards,
Markus

