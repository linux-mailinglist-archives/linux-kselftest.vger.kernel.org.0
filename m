Return-Path: <linux-kselftest+bounces-2230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198C818CD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F11B250B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926B208C1;
	Tue, 19 Dec 2023 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUvsQkVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9720311;
	Tue, 19 Dec 2023 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=EOCD7Shlg2KFEVb25pFCb4aRILZyHRKFnKAAS7R3DdM=; b=YUvsQkVW2VCdKuroGCXVzxdaZl
	21cJwKUkRqR63J8X6RhppnFmHFYn/C+Ft6YRoCxEcn+6ppHrR3CZNwX1ckQ6d5waZWUQt8lUHekdl
	k4EHJm9LeGidlILKwvWHic/XLw9Rt6+6LbqTg8B4bh3R/XzdVBDtuDi8fAqm+DcTZv/OdcNwe3yOR
	u8J+z1elCamCtlwvEeeNWuZmqf//VckZq5qTwj3oEFxI4eRBWamhceUWzcuHCoabS+sEShd9hi1gl
	m9b4+q/EzV8aocjU7AbZl2aBbeKHX4Xs1ZeK0SFn5EPpFbWU0EPrAq3Z+mLEfmdmYnvA6J61TeG/F
	5KG8Obfg==;
Received: from [2001:8b0:10b:5:20dd:b45a:6fd4:1db5] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdEv-00DXFG-1F;
	Tue, 19 Dec 2023 16:46:41 +0000
Date: Tue, 19 Dec 2023 16:46:40 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 16/19] KVM: xen: split up kvm_xen_set_evtchn_fast()
User-Agent: K-9 Mail for Android
In-Reply-To: <20231219161109.1318-17-paul@xen.org>
References: <20231219161109.1318-1-paul@xen.org> <20231219161109.1318-17-paul@xen.org>
Message-ID: <5B3EDE03-67F4-4BA2-89AA-F882DB6DE702@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 19 December 2023 16:11:06 GMT, Paul Durrant <paul@xen=2Eorg> wrote:
>From: Paul Durrant <pdurrant@amazon=2Ecom>
>
>The implementation of kvm_xen_set_evtchn_fast() is a rather lengthy piece
>of code that performs two operations: updating of the shared_info
>evtchn_pending mask, and updating of the vcpu_info evtchn_pending_sel
>mask=2E Introduce a separate function to perform each of those operations=
 and
>re-work kvm_xen_set_evtchn_fast() to use them=2E
>
>No functional change intended=2E
>
>Signed-off-by: Paul Durrant <pdurrant@amazon=2Ecom

Reviewed-by: <dwmw@amazon=2Eco=2Euk>

Would still like to see the xen_shinfo_test use an evtchn port# which trig=
gers the bug in the precious version=2E


