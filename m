Return-Path: <linux-kselftest+bounces-8612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C498ACCB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A512805FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0A1474D8;
	Mon, 22 Apr 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgzgoQQz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19C1474BA
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788592; cv=none; b=vFiGWf/iLx6BiRRsz6deUhkKQCOIgvhw+w10KUu99iXHUiQgtsE4k2GEj10QzJEAPG4VP0QsGqt5dnfNi4MHliObnap3N00OW2yDn0TqxHjIEikG+BhhnBhK9D1nP6SaVAxqoW6/CVi8pVwBT+uQEXLeyHb6wwlV8fsYQd5irDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788592; c=relaxed/simple;
	bh=F7obnOZNB7/UePlmQ4/swyiJSlSeyZSBbGTCgkyWlp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFeV6zq9gN8SE+E+k0sfbI2nZN7uAhqjkq553FdPkeRkH58jTf1RGhHwWLzG9dQDqP1JOMc0Wa37d4uISvotBAXInJECg/hjOOV3Bd+nXNqKfQNMUqlbpwO/JZEZ9NxEOpCn+TCk0FcL6ZAvBNIEvsUV/R/fNZQ0GkGSz/LX0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgzgoQQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713788589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/ezKDbA2HN619P+c1weExzZDrmAB50w8fBX12Fo+H4=;
	b=RgzgoQQzTMOZ7aVHY1hTqMOIbsOX7cPZUIEFkvzihFfkjBCNjmbFTyLnmReYBMVpkCRRoP
	bDwQ30ek7plDHfzRqtNHga9w1bmm4wwuVVdvcndoIiuPuzB+tC4VZsq0WKBNXGg2aTL77O
	+LSfHWrbmYTUkv9fO7zKpX8zkUr6Rck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-BauQKvvtNWmj6mx9oAdFPA-1; Mon, 22 Apr 2024 08:23:08 -0400
X-MC-Unique: BauQKvvtNWmj6mx9oAdFPA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e46df264so3022862f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713788587; x=1714393387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/ezKDbA2HN619P+c1weExzZDrmAB50w8fBX12Fo+H4=;
        b=S9uJjxF2tTm+aVD54S/chLepmiU0figGB/e2TLQMF4dS8UUo3WztrqRMsZRCPzyTDq
         zd/XrvdMepDX41eOaGoML7egKMQSA+hnr03rhOwOtLgi6oEjUkDIH0eJYgD7LtL0euUy
         JUF8EvwvPBSAFMgCezCVSxSoWEzIdOrzhRt+9bYCwXjabq0PnDmtWR/btxVcaXqKOmNm
         70htJI8EZfbkiuYsVvCWi5v3o3v7pSh1/k4Aj8F+MMCjy1h5/emSpIg8TjVVVdx58Atp
         ZLdugIDD4Isr+tdBo7BJvIBMBYjMAFwvVSOziDNt4QP4YeD8MpsX78jTLTiybT5el9UH
         UssA==
X-Forwarded-Encrypted: i=1; AJvYcCUwzh77nA9QYtfgImAN32suAMU/iYktei2/WV46F1ndb75CbLk9ICqgMq43Q5V18H9wLjiq5Qq6UnzXwjCqwb4opOUuw8o0OrDW54qWMQsr
X-Gm-Message-State: AOJu0YzzsNNDnjs3Z9/V32KJOjqw2Z0zJicSdC5wobGsU+ZYWybiFRiv
	SzrL5pwko8i+luAhmENYizPkuCWb3IAsbpxLGrsa5GGgAbzlEMUeo2CTV9lrabOkaF0+NYt9dbD
	KuelU+vX9Js1esldMzSQNrtHWUjdir5HM49ZonxsFsqUQkjNoln0+AJRIzgKW9cLWzLj20CxwFI
	wTDr531NZnRs5Ib8SIzqwxq4+YQtU+U19eC1bSfSkp
X-Received: by 2002:adf:e912:0:b0:34b:4d2e:47d4 with SMTP id f18-20020adfe912000000b0034b4d2e47d4mr500949wrm.24.1713788587155;
        Mon, 22 Apr 2024 05:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3h4OmL+jYFXwcCkMIHWemcojF5sGIioXy21Ag0m5VdsfhXioLRiKuxM9attN9d1n5rFQo9UJTzdn+57ydq+I=
X-Received: by 2002:adf:e912:0:b0:34b:4d2e:47d4 with SMTP id
 f18-20020adfe912000000b0034b4d2e47d4mr500928wrm.24.1713788586839; Mon, 22 Apr
 2024 05:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418193528.41780-1-dwmw2@infradead.org> <20240418193528.41780-3-dwmw2@infradead.org>
In-Reply-To: <20240418193528.41780-3-dwmw2@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Apr 2024 14:22:54 +0200
Message-ID: <CABgObfa0j34iEh81hhd7-t7ZM1GKAsvJb5xP6EoD2-c-8TnPqQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] KVM: x86: Improve accuracy of KVM clock when TSC
 scaling is in force
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Marcelo Tosatti <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:51=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>         gpa_t time;
>         struct pvclock_vcpu_time_info hv_clock;
> -       unsigned int hw_tsc_khz;
> +       unsigned int hw_tsc_hz;

Why not change this to u64? 4.3 GHz is scarily close to current
processors, though I expect that it will break a lot more software
than just KVM.

>  static int kvm_guest_time_update(struct kvm_vcpu *v)
>  {
> -       unsigned long flags, tgt_tsc_khz;
> +       unsigned long flags;
> +       uint64_t tgt_tsc_hz;

... especially considering that you did use a 64-bit integer here
(though---please use u64 not uint64_t; and BTW if you want to add a
patch to change kvm_get_time_scale() to u64, please do.

Thanks,

Paolo


