Return-Path: <linux-kselftest+bounces-39339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E829B2CF99
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D63BD6B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568B72222C4;
	Tue, 19 Aug 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="an/4N+CC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE8246BA5
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644713; cv=none; b=c8qXmhATBdokF/qw05UfeMYA6++MnvwpUuCVHdrIg5WXq1iyhjreCru0eFWPfBB+6WSo9Tq2mxTawovxyB+TaqKhLO92eifyqiRi3U9bkr3sRShXLnFBMaAa5GhmddhzjhKB4JoDn4Oa1BFvE6sjIZpTVC7miaiThYvBNmrf+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644713; c=relaxed/simple;
	bh=s57YALn7gVQdX0MKPvHRRNAjkYPbaKEVpBGjPx0awnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ba54mNesMK7VV4eEY0+4tY2V1XSNJCcyT2jMx7s6Lkvw/YR5XUBVSMaYHF8W/dH75JohhWGq8XQ4J1AOt6jUub36vCRai3QVpsQKwnOVDVE3S6vZTaEryiJSj2HM+EoTVVBcvSmssBvFq3GOzbhnylV/Fe9KUctH45fX5qgZVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=an/4N+CC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266b700cso11639955a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644711; x=1756249511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s57YALn7gVQdX0MKPvHRRNAjkYPbaKEVpBGjPx0awnc=;
        b=an/4N+CCDc0jKsyqFzPoCPTD7TmK5g9pAFTlVwppUp64ZTDY6+dIamscGEaamI7lkX
         Fr6m9YXMUm3YHZxbMIfJpYd8noKAkuVtOwO2CnCRxAdDO0lpPf8nNNcsxWjpolUuUjpC
         J6TKiJxPxrQzoS+bVm+x1O0ZhlgGg6JPOebKxgy697iw/gbevcOYVx9nOM2Im4uxN3ey
         E+hfou0sKLJduqw7Xhv8M85Nsvio3DapcKFdAcYC25aohtTLruURkGY62xT1ZRJ5R9hR
         uBv+qwPnZlW6l3I9gILHX/9KXEiu5Rv1My8/BOfHA+jJIbwppV9/uDDQrDx/teEc8+vO
         UpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644711; x=1756249511;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s57YALn7gVQdX0MKPvHRRNAjkYPbaKEVpBGjPx0awnc=;
        b=oypYMJ3bvGJ3UUOL8dtCQUZLMWrwW/8WNHOVAZ31mkbQVn3Z3S3vzbyJ1zXXXS33V6
         oSVk1RgEyDj3ILA03MZX+3eyY9+nf0j1rGsk26prj9OeGoToNmyegiUxmbcnZC2YUM18
         FX3oJvshicnHla41loeY9Mdmsig1kia1b1o8eqNgIkW8BVKfYeKxoJJiJnSpKf365mkW
         caZKhnpMx1C0A2dIsifQCdwn+OjAqU5fGzLYty9KvBM69IBB62nFOpG7+V18vVs2dK8a
         +gaT2jNPMmVup8cQrl68Ry/2g/OPSP0AOxKyGPNlCHaJmuJfyXzJs5vnXdXyPi+xkkhg
         d8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk7NN/8peNO590uxpSpNDHeo08DgoNdCoJ2oay/ztJ1L7Z0LS1pkpnfSvjln+sA2O9L2cWvj4ATkSpV2BzYXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNWIkolG5SlN03BXDPlCbq0pliDqu6aeBIhB+09iXyN+8Vz6b
	3biklM4waGEt9PGShINSRh/1T+aR6pTSz2jnlKeIaH0k/Stl+GRdilHroPy6sKSyLNv0kR2dL70
	FBQv45lN27A==
X-Google-Smtp-Source: AGHT+IHqM06mS21QPq1I85PoYm4HgMV/ruKHvkhc5ta3MWpAbBvms4h38a9xCaOs0YWBBkFUxXap50j2LlK9
X-Received: from pjyp12.prod.google.com ([2002:a17:90a:e70c:b0:31e:a094:a39])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5623:b0:31f:210d:2e56
 with SMTP id 98e67ed59e1d1-324e140bf9amr1034862a91.28.1755644711105; Tue, 19
 Aug 2025 16:05:11 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:05:09 -0700
In-Reply-To: <ftydqeu3zxmgdvkz6f4jrf4qyrs72ar7jc4j3khlkyi4mditfe@g62znohovca7>
 ("Michal =?utf-8?Q?Koutn=C3=BD=22's?= message of "Thu, 14 Aug 2025 18:18:47 +0200")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805032940.3587891-4-ynaffit@google.com> <20250805032940.3587891-6-ynaffit@google.com>
 <ftydqeu3zxmgdvkz6f4jrf4qyrs72ar7jc4j3khlkyi4mditfe@g62znohovca7>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx81pp6syje.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v3 2/2] cgroup: selftests: Add tests for freezer time
From: Tiffany Yang <ynaffit@google.com>
To: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+IHdyaXRlczoNCi4uLg0KDQoNCj4gCWlm
IChjdXJyIDwgMCkgew0KPiAJCXJldCA9IEtTRlRfU0tJUDsNCj4gCQlnb3RvIGNsZWFudXA7DQo+
IAl9DQo+IAlpZiAoY3VyciA+IDApIHsNCj4gCQlkZWJ1ZygiRXhwZWN0IHRpbWUgKCVsZCkgdG8g
YmUgMFxuIiwgY3Vycik7DQo+IAkJZ290byBjbGVhbnVwOw0KPiAJfQ0KDQo+IEkgbWlnaHQgbGlr
ZSB0aGUgdmVyc2lvbiB3aXRoIGxlc3MgaW5kZW50YXRpb24gYW5kIGV4cGxpY2l0IGd1YXJkcy4g
SXQncw0KPiBvbmx5IG1pbm9yIHN0eWxpc3RpYyBpc3N1ZS4NCg0KDQpOb3RlZCEgV2lsbCBiZSBm
aXhlZCBpbiB2NC4NCg0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiAyKSBGcmVlemUgdGhlIGNncm91
cC4gQ2hlY2sgdGhhdCBpdHMgZnJlZXplIHRpbWUgaXMNCj4+ICsJICogICAgbGFyZ2VyIHRoYW4g
MC4NCj4+ICsJICovDQo+PiArCWlmIChjZ19mcmVlemVfbm93YWl0KGNncm91cCwgdHJ1ZSkpDQo+
PiArCQlnb3RvIGNsZWFudXA7DQo+PiArCXByZXYgPSBjdXJyOw0KPj4gKwljdXJyID0gY2dfY2hl
Y2tfZnJlZXpldGltZShjZ3JvdXApOw0KPj4gKwlpZiAoY3VyciA8PSBwcmV2KSB7DQoNCj4gSGVy
ZSBhbmQuLi4NCj4+ICsJCWRlYnVnKCJFeHBlY3QgdGltZSAoJWxkKSA+IDBcbiIsIGN1cnIpOw0K
Pj4gKwkJZ290byBjbGVhbnVwOw0KPj4gKwl9DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIDMpIFNs
ZWVwIGZvciAxMDAgdXMuIENoZWNrIHRoYXQgdGhlIGZyZWV6ZSB0aW1lIGlzIGF0DQo+PiArCSAq
ICAgIGxlYXN0IDEwMCB1cyBsYXJnZXIgdGhhbiBpdCB3YXMgYXQgMikuDQo+PiArCSAqLw0KPj4g
Kwl1c2xlZXAoMTAwKTsNCj4+ICsJcHJldiA9IGN1cnI7DQo+PiArCWN1cnIgPSBjZ19jaGVja19m
cmVlemV0aW1lKGNncm91cCk7DQo+PiArCWlmICgoY3VyciAtIHByZXYpIDwgMTAwKSB7DQoNCj4g
Li4uaGVyZQ0KPiBJJ20gc2xpZ2h0bHkgd29ycmllZCBpdCBtYXkgY2F1c2UgdGVzdCBmbGFraW5l
c3Mgb24gc3lzdGVtcyB3aXRoIHRvbw0KPiBjb2Fyc2UgY2xvY2sgZ3JhbnVsYXJpdHkuDQoNCj4g
SXMgdGhlIGZpcnN0IGNoZWNrIGFueWhvdyBtZWFuaW5nZnVsPyAoSSB0aGluayBpdCdzIG9ubHkg
YXMgc3Ryb25nIGFzDQo+IGNoZWNraW5nIHJldHVybiB2YWx1ZSBvZiB0aGUgcHJlY2VkaW5nIHdy
aXRlKDIpIHRvIGNncm91cC5mcmVlemUuKQ0KDQoNCkhtbSBJIGhhZCBvcmlnaW5hbGx5IHB1dCB0
aGUgY2hlY2sgYXQgMikgaW4gdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHZhbHVlDQppbmNyZWFzZXMg
YXMgZXhwZWN0ZWQgZm9yIGFuIGVtcHR5IGNncm91cCAodGhlIHNpbXBsZXN0IGNhc2UpLCBidXQg
SQ0KdGhpbmsgdGhlIGNoZWNrIGF0IDMpIChhbmQgbW9zdCBvdGhlciBjaGVja3MgaW4gdGhlc2Ug
dGVzdCBjYXNlcykNCmVzdGFibGlzaCB0aGUgc2FtZSB0aGluZy4NCg0KVGhlIG90aGVyIHB1cnBv
c2UgaXQgc2VydmVzIGlzIHRvIGFjdCBhcyBraW5kIG9mIGEgYnVmZmVyIGZvciB0aGUgdGltZQ0K
aXQgdGFrZXMgdG8gZnJlZXplIHRoZSBjZ3JvdXAgKHRfMSAtPiB0XzIpIHRvIGVuc3VyZSB0aGF0
IHRoZSBjZ3JvdXANCndvdWxkIGJlIGZyb3plbiBmb3IgdGhlIGVudGlyZXR5IG9mIHRoZSBzbGVl
cC4gSS5lLiwgcHJldmVudGluZyB0aGUgY2FzZQ0Kd2hlcmUgd2UgZmFpbCB0aGUgY2hlY2sgYmVj
YXVzZSB0aGUgdGltZSBtZWFzdXJlZCBhdCB0XzMgZW5kcyB1cCBiZWluZw0KKDEwMCAtIHRoZSB0
aW1lIGl0IHRvb2sgdG8gZnJlZXplKS4NCg0KVGhhdCBzYWlkLCB0aGUgdGltZSBiZXR3ZWVuIHdy
aXRpbmcgdG8gYW4gZW1wdHkgY2dyb3VwJ3MgY2dyb3VwLmZyZWV6ZQ0KYW5kIGl0IGJlZ2lubmlu
ZyB0byBmcmVlemUgaXMgYmFzaWNhbGx5IG5lZ2xpZ2libGUgcmVsYXRpdmUgdG8gdGhlIHRpbWUN
CnNjYWxlcyBpbiB0aGlzIHRlc3QsIHNvIEknbSBoYXBweSB0byB0YWtlIGl0IG91dCENCg0KKElm
IHdoYXQgSSd2ZSB3cml0dGVuIGFib3ZlIGlzIHdvcmRlZCB0b28gY29uZnVzaW5nbHksIGlnbm9y
ZSBpdC4NClRMO0RSOiB3ZSBkb24ndCBuZWVkIHRoaXMgY2hlY2shIEknbSB0YWtpbmcgaXQgb3V0
ISkNCg0KPiBXb3VsZCBpdCBjb21wcm9taXNlIHlvdXIgdXNlIGNhc2UgaWYgdGhlIGxhdHRlciBj
aGVjayB3YXMgYXQgbGVhc3QNCj4gMTAwMMKgzrxzIChiYXNlZCBvbiBvdGhlciB1c2xlZXBzIGlu
IGNncm91cCBzZWxmdGVzdHMpPyAoRGl0dG8gZm9yIG90aGVyDQo+IDEwMCDOvHMgY2hlY2tzLikN
Cg0KTm90IGF0IGFsbCEgSSdsbCBtYWtlIHRoaXMgY2hhbmdlIGZvciB2NC4NCg0KVGhhbmtzLA0K
LS0gDQpUaWZmYW55IFkuIFlhbmcNCg==

