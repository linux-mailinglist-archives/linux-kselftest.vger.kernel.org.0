Return-Path: <linux-kselftest+bounces-36121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00759AEE60F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6013F3B6C45
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF132E6113;
	Mon, 30 Jun 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCAHmmTL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39C291C30
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305376; cv=none; b=OmCRcXGWVQLicUkD7LGEyNptoUqsNtI3N2TmbfWKxSiZEOKkaRZftBc1ICeaDsHCjLG1Jx82C48qx09UoZNXMbEmvqVRyMw1ZHcRP6qxtdhu73ZmNyb2brqNCRYt0ecMYp57B+VpvSJmyCv3UogZnlIdQE2CFTR+sZmfQqUu4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305376; c=relaxed/simple;
	bh=p9QHb3/hnKvWZKIXq5Fvg8ndjho6Otu5IGRMFihrTnE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=chvkjw4+8UMfqpdY0FJGZG9mHwmFTFl5BjHmTzuz2L6kXbLMxH9ofq6zVF68XB68NGZfWRCdWT/wWtcyRDg6R1FAX7mAikfVlgYmYpH/e155i3o8sGFMGOjXfQByuZwRs6k0VDWKKfs3N77erC9uzXxIuaU8rxoQQ+PlQ7oFpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCAHmmTL; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3df2e89fd03so23374505ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751305373; x=1751910173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImVsekYPJx+C4taW0n4SjIxS/mjgVChiR4QEyhkYP6w=;
        b=LCAHmmTLlc7LAL9IhX3jzPcQ2WgcZGwwRiWm0xZqvthjUhf9xOGL3xxTV0q5Y15+3z
         jvgDdqoloX97kyUqiC114rGfNYt8i8hYUDZsVOg44g8zsers9SA7WItxZdcuQAMTeBS8
         caDBoOK9ePCqQ8SaACgl9PKgpCMdYcFwllcxDTdXHRyzNmJCLPdEa+jqYPV41FJ7LHDH
         udAsChdeeY+kG61aHeWfqL8rjP9rZOlLinOxZoYqK49gI56wiJ/vGsSJYU+Ciqy+Y9KX
         sOSgF29NYSEpQNpjqG0VUYPAbY0XrVNKCufua4aislkVEu69wRl8MF1qPmEEzSTnFcuQ
         tuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305373; x=1751910173;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImVsekYPJx+C4taW0n4SjIxS/mjgVChiR4QEyhkYP6w=;
        b=gJImIWd7zVb/RsYAAsCbCPIlzp2YPJIRXF6Zkg5c+z9veiK8mZVLsc9zixpE1nWx5q
         vVOqbg2zugdzSDgstN2/lUQv1kMFgXlLzHdozvgBkj2ahT6+gS3oBwlWQOLHDQqBK/Ar
         cZmLEnBXNEds4PgklOR8/a0E4u94X7ajxyj/CESjvIV9sP1gwafG2Ai0Uk37wpa+Xv7J
         VdX9Y2cMOzRIszEBpxBf/VrIpkFVEfZ81Afmgyzn2xblQ0nktp8YNnN9LEVCyX41DhMz
         0j18xGNHH1alCq1gg2pgAK2Qc5VUXqBCOu4BlaJ3dZ1/skQHUKciacY+ma3jJCHTVdRV
         nN7g==
X-Forwarded-Encrypted: i=1; AJvYcCWbjCdQhMmmNCD9pKPTO4kkeMVmbD707OdqFwFfwkXg8+S1ylUyNdvAwXC3zllqZ0pAIi1EhxFv1Sdmw1eScr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnQY9H/NkqMffBvybGuhKbeqmXB7XUNlbwVc0vQ/pjM+BU0nB
	dhxChgmihutQJeoHnIyjlhle97IWD7vJoylkiD1nqme7N+mrw/LjQ03g93X7jZHXUN+A0jiKbhS
	nMB+Tqbzq8/2uRk9tnk7BZa7MlA==
X-Google-Smtp-Source: AGHT+IF9nPhO3RxMhccQIRyozfA0RZ1o/n5EUvH0ZvYssIkGUujSgAHo5a6XMuPc/RTrNVL6l8tA4e7hfnuN+vQINg==
X-Received: from ilbbc5.prod.google.com ([2002:a05:6e02:85:b0:3df:2ece:7197])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3c85:b0:3dd:b808:be59 with SMTP id e9e14a558f8ab-3df4acc61ecmr180573955ab.21.1751305372798;
 Mon, 30 Jun 2025 10:42:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 17:42:52 +0000
In-Reply-To: <aF8FPTupC_VnAldN@linux.dev> (message from Oliver Upton on Fri,
 27 Jun 2025 13:55:25 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt4ivx86sj.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: ben.horgan@arm.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, mizhang@google.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> On Fri, Jun 27, 2025 at 08:45:38PM +0000, Colton Lewis wrote:
>> Hi Ben. Thanks for the review.

>> Ben Horgan <ben.horgan@arm.com> writes:

>> > Hi Colton,

>> > On 6/26/25 21:04, Colton Lewis wrote:
>> > > There's no reason Enums shouldn't be equivalent to UnsignedEnums and
>> > > explicitly specify they are unsigned. This will avoid the annoyance I
>> > > had with HPMN0.
>> > An Enum can be annotated with the field's sign by updating it to
>> > UnsignedEnum or SignedEnum. This is explained in [1].

>> > With this change ID_AA64PFR1_EL1.MTE_frac would be marked as unsigned
>> > when it should really be considered signed.

>> > Enum	43:40	MTE_frac
>> > 	0b0000	ASYNC
>> > 	0b1111	NI
>> > EndEnum

>> Thanks for the explanation. I made this a separate commit because I
>> considered people might object and HPMN0 is already an UnsignedEnum in
>> my previous commit.

>> Do you think it would be a good idea to make plain Enums signed by
>> default or should I just remove this commit from the series?

> It is presumptive to associate a sign with an enumeration. Generally
> speaking, the only fields that can do signed / unsigned comparisons are
> the Feature ID register fields.

> So please drop this and only keep the change for HPMN0.

Done.


> Thanks,
> Oliver

>> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> > > ---
>> > >    arch/arm64/tools/gen-sysreg.awk | 1 +
>> > >    1 file changed, 1 insertion(+)

>> > > diff --git a/arch/arm64/tools/gen-sysreg.awk
>> > > b/arch/arm64/tools/gen-sysreg.awk
>> > > index f2a1732cb1f6..fa21a632d9b7 100755
>> > > --- a/arch/arm64/tools/gen-sysreg.awk
>> > > +++ b/arch/arm64/tools/gen-sysreg.awk
>> > > @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" ||
>> > > block_current() == "SysregFields
>> > >    	parse_bitdef(reg, field, $2)

>> > >    	define_field(reg, field, msb, lsb)
>> > > +	define_field_sign(reg, field, "false")

>> > >    	next
>> > >    }

>> > Thanks,

>> > Ben

>> > [1]
>> >  
>> https://lore.kernel.org/all/20221207-arm64-sysreg-helpers-v4-1-25b6b3fb9d18@kernel.org/

