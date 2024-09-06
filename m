Return-Path: <linux-kselftest+bounces-17421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5C96FC6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698F01F27AE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6441D7E39;
	Fri,  6 Sep 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye0S05pp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938E1CBE8C
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652658; cv=none; b=EOr3K3Y/PKtBvMTqHxCMxEAWDx5h/i1XKlxO6omlNeIDxGlRLH2sRALyjX5HOBnhvj4ZK3/tETeyFNN/h5w17gmxBFKEqrycDc0KIw9XGYgqOfSFMhVm4XBb+7CcyyjGqJlIsoAme60I6rO6jvDtmaE7kgbi41JldruKEZuXMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652658; c=relaxed/simple;
	bh=5jt3ut579SUAV6huLfoT22jkBdXDOCD7fs9D7oNlTsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7DPCiFz5GX+rDNIAwutdju4QrP3B/BJhpeXq7msXcdXTuBuZZNyCaqJS7lTPO4nxgZyqLUMeYjAxM3Wqx8VrttJQkYb6Cz1sBsLmolRWJVFMRkqH9WpcYtaAT/eeSrwZF3QeTHvK7fye++dLS9U4msOHINYfAZmZ7VWi0P+wUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ye0S05pp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so1759776a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725652656; x=1726257456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GoE4RbZ3FX54VqsyfP6GLqg58f68KZb1fc5pIob7R0=;
        b=Ye0S05ppH6hkt7QV6KT6Wiui1kdEj2orEawsv9n4qVKkHuXCEUMHwrTlgLC8WLuGjH
         FA303KOGGImO7eNrctnEvTy50DNYUoJO8uQjciQfbOMod0WVchgCo/zWQe+3x7GywZ9V
         eTel1ecJlgSA+l+/ELF5HnzdEIzP+JiCN7ZlJ/vu+HqBn7xu5RSmnzwRQXUGb7RsKBld
         PnOuh5ZCjGLRNlr31CPQtuqgDKi1RCNBNHSscP1wDTryp5WfrnIX5Bh+CLJ16fTKQzHQ
         rtuKf6t8lhBoLohdLpafIkS96yTnvi8VNZGUk3T+lYTDQ5OqhxC9194uQArgmo+3lgJ+
         ezSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652656; x=1726257456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GoE4RbZ3FX54VqsyfP6GLqg58f68KZb1fc5pIob7R0=;
        b=JDZl4T8bOk5rLEK3kngEIlckJI81PvuWdkfKE6QxISfLOarur62C+0GqQiUA4B4REo
         H05xG4H8v5fYXASTqHItlTmgB72+gaplhi+qu/pIMeu/0bmmef7k9EoW3d2YN3ql9YLM
         3iurZh1kOJ2YAM8GjwGJL73XyYmZ4qLS6JfPRVa2+wGWLhxknbpT0nPv6LjkC6cNhqPF
         y96DWtk8ISYcyfgwjyNmIyD05Vs5T7kvE6du3uE2qrZs9uZMiiVe7U5R+fFTsyNgFLKu
         ZZZNBycfJsdcyYvcMWyEaCxhOvC8Upb5VHiFPa0QLzVEOKgKmztcnJowp65kkq6PaHWj
         PanA==
X-Gm-Message-State: AOJu0YwA9vMJXI8VfdYNPC6FTVLilKihUIolPKTQaNsev9nvqFfyFNpx
	mH53aY+iUP6GpcyJg9feFyDfaI0Cra0ubJqcLzQlnq/GsbQIybtq4FJmWpboWYR4Qq+nA7A/Pb9
	BOIXPdeqLolcv05vW1PI+oL53XbiWutSBwVLz
X-Google-Smtp-Source: AGHT+IF63yRUHfE/gc5IqEr6BtvKdXrIxPhosSmQhjUQNG0x0KM2wbpd2Rr5uwWBceFcfoVvK54usKU7Q6DSaw9LZ0o=
X-Received: by 2002:a05:6a21:710a:b0:1cc:dd3a:ed43 with SMTP id
 adf61e73a8af0-1cf1d0b3ba9mr3866935637.12.1725652655789; Fri, 06 Sep 2024
 12:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183150.1616-1-michal.wajdeczko@intel.com>
 <CA+GJov5POvegznZutxHZuoUhxeHyseECHm4GW5NMR5vqZGWk4g@mail.gmail.com> <63952c61-d00b-421a-be9d-e7b940325f38@intel.com>
In-Reply-To: <63952c61-d00b-421a-be9d-e7b940325f38@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 6 Sep 2024 15:57:23 -0400
Message-ID: <CA+GJov4ZR6Cfms-j8v3xVSj10L1_4JptQfYt6tqZGi1s=0cyBQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kernel-doc for EXPORT_SYMBOL_IF_KUNIT
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:28=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 29.08.2024 20:58, Rae Moar wrote:
> > On Thu, Aug 29, 2024 at 11:32=E2=80=AFAM Michal Wajdeczko
> > <michal.wajdeczko@intel.com> wrote:
> >>
> >> While kunit/visibility.h is today not included in any generated
> >> kernel documentation, also likely due to the fact that none of the
> >> existing comments are correctly recognized as kernel-doc, but once
> >> we decide to add this header and fix the tool, there will be:
> >>
> >> ../include/kunit/visibility.h:61: warning: Function parameter or
> >> struct member 'symbol' not described in 'EXPORT_SYMBOL_IF_KUNIT'
> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >
> > Hello!
> >
> > This looks good to me. Thanks for adding this. We will need to do a
> > patch on making this recognized as a kernel-doc at some point.
>
> here it goes [1]
>
> [1]
> https://lore.kernel.org/linux-doc/20240829202529.1660-1-michal.wajdeczko@=
intel.com/

Hi Michal!

Thanks for your fast response to this! It looks like this patch
changes the kernel-doc specification, which is a very worthwhile
conversation, but in this instance I intended to change the code
comments in visibility.h to match the current kernel-doc
specification. I am also happy to make those edits in a future patch.

Thanks!
-Rae

>
> >
> > Reviewed-by: Rae Moar <rmoar@google.com>
> >
> > Thanks!
> > -Rae
> >
> >> ---
> >> Cc: Rae Moar <rmoar@google.com>
> >> Cc: David Gow <davidgow@google.com>
> >> ---
> >>  include/kunit/visibility.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> >> index 0dfe35feeec6..efff77b58dd6 100644
> >> --- a/include/kunit/visibility.h
> >> +++ b/include/kunit/visibility.h
> >> @@ -22,6 +22,7 @@
> >>       * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
> >>       * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
> >>       * in test file in order to use symbols.
> >> +     * @symbol: the symbol identifier to export
> >>       */
> >>      #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
> >>             EXPORTED_FOR_KUNIT_TESTING)
> >> --
> >> 2.43.0
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "KUnit Development" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to kunit-dev+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/kunit-dev/20240829183150.1616-1-michal.wajdeczko%40intel.com.

