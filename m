Return-Path: <linux-kselftest+bounces-18758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C238B98C163
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FE6B2267D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D541C243D;
	Tue,  1 Oct 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfTWBCft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFE26AF6
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795837; cv=none; b=O5skrbNMuhsWFTRxTmXNYpkihTgZs9BiHnWcdUD9YAkF8XO7dZpKiInVy1GH9vE/7fE+JgU/7lgPa4pLDD7SGRq5SnW/+Fa82Qb9uF9QWgbqHIjC9NjuY6RortEQWnk1SlPd8ObtsA73tuMW96nKoEi2seOQzHUP9FIsJO/71nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795837; c=relaxed/simple;
	bh=EgaHePArQR7nWkAan1+KnfXGKtMNGcoZX20Y9veixIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BziDytIc28rhYmG7zp05EgzPOA2IPXY/IA/MkxOto2Hvamp8yo63srlK1RWst6SAH/66qAobm+R3cF30MPs/LFGieZOX1Z9clWitI+Vz9p8PnDfMGh3QxSblq5Uu/phQ+VBqSDN/jdT/qpe0hQJvioamqAjQRVRJvUrqt7tmw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfTWBCft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727795835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqAP4dtv2u7sS+Z81oPV4fE+lGbUyKHeK4mPtJ9hr/E=;
	b=BfTWBCftmAkYIcZ+DHfptjAIQeHU3hGpR0Ynmig6ZSN5cNzKxTOgQXswQkBkfuRnvXT0fF
	24KSLuIAjgmYUkZw/5wmizzHbkuMdfUUXnzrUK5ijCo46AoWvfm3SM8zFhWHW1X9jfvQoS
	8EpBZrmwZa0JejXd1OzGAfRoNhdo1PI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-uYoabkAFNeWq3YLUG1_x9Q-1; Tue, 01 Oct 2024 11:17:14 -0400
X-MC-Unique: uYoabkAFNeWq3YLUG1_x9Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42e77b5d3dcso37464955e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 08:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795833; x=1728400633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqAP4dtv2u7sS+Z81oPV4fE+lGbUyKHeK4mPtJ9hr/E=;
        b=h4qhxH04AjNTLmGMhN0HVQbtME2PrCxhvmfdRjTmnHFsLU0l8KDK2zW1jUOrZlJoXR
         mzeEVMjtwutG4q/aLv21mKoCRqEP0WLocSsG/683k2bBY+lyiYfsAw0RDf0X3GE1TraW
         59l1DM/p7paIYhgOgMHnpFq8MQ7NOyyIxLLc0kmTefB46Uzm5nenKLHBVmUVinUufruy
         4W09NVtxFlmZ6LKWUPgnqZUhDHnORt2X9C7EQWM8nyWvjhATay6ouTMScfrKTeY3x309
         G3wmlpoJl0E07qqWlcH2x2UrarmwWhXhVo3T1b9+AtRD4OCrgIf2SMLoEgJt9IkokKoz
         dNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwQIXWu6hYHs/B2SyUKFhYtx5YMJ9Y1D3C659tyLEsOmx95CsIU8OM+m9yliDq31VSjAoW+D3askzO3YNLiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcFzz+0Lqg8SmjLRe8El8hhNcUeUUZAR982Y/HOqnlm7LsUOA
	GYQd7RZL34EklNzC/EllU6kF3kj40QdnT9QTXZlYIVKOT8nZRprCh+cxLNZMvRCOjo8D8spxo3g
	1EqDZ2vIH1ngS4FjMZYsxrG88CXIS7WYWYCnnCoCAtbTfBVCrI8mHPN1QmmxnHyFxeZgxszwGXc
	dsLm1krBWfroaWrjwdotc812f9/ZudJtg9B5N+QHuX
X-Received: by 2002:a05:600c:2154:b0:42c:dce1:8915 with SMTP id 5b1f17b1804b1-42f5b9310b1mr110366365e9.33.1727795832946;
        Tue, 01 Oct 2024 08:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdYi/KYMxTdYvq3EwnDXusLPrnPH+Z3WqQf0HLO3BTobGAMefwExTx6xCH53Aan9BVB1uZBnMH5NIK5dLGhMo=
X-Received: by 2002:a05:600c:2154:b0:42c:dce1:8915 with SMTP id
 5b1f17b1804b1-42f5b9310b1mr110366165e9.33.1727795832574; Tue, 01 Oct 2024
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-kvm-build-breakage-v1-1-866fad3cc164@kernel.org>
In-Reply-To: <20240930-kvm-build-breakage-v1-1-866fad3cc164@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Oct 2024 17:16:58 +0200
Message-ID: <CABgObfabFVV4yuku0w7U0MMYk3Nbh22j47GcKt=2w7=H_zWj7A@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix build on architectures other than x86_64
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> The recent addition of support for testing with the x86 specific quirk
> KVM_X86_QUIRK_SLOT_ZAP_ALL disabled in the generic memslot tests broke th=
e
> build of the KVM selftests for all other architectures:
>
> In file included from include/kvm_util.h:8,
>                  from include/memstress.h:13,
>                  from memslot_modification_stress_test.c:21:
> memslot_modification_stress_test.c: In function =E2=80=98main=E2=80=99:
> memslot_modification_stress_test.c:176:38: error: =E2=80=98KVM_X86_QUIRK_=
SLOT_ZAP_ALL=E2=80=99 undeclared (first use in this function)
>   176 |                                      KVM_X86_QUIRK_SLOT_ZAP_ALL);
>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Add __x86_64__ guard defines to avoid building the relevant code on other
> architectures.
>
> Fixes: 61de4c34b51c ("KVM: selftests: Test memslot move in memslot_perf_t=
est with quirk disabled")
> Fixes: 218f6415004a ("KVM: selftests: Allow slot modification stress test=
 with quirk disabled")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Queued, thanks.  Sorry for the disruption.

Paolo

> ---
> This is obviously disruptive for testing of KVM changes on non-x86
> architectures.
> ---
>  tools/testing/selftests/kvm/memslot_modification_stress_test.c | 2 ++
>  tools/testing/selftests/kvm/memslot_perf_test.c                | 6 +++++=
+
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test=
.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> index e3343f0df9e1..c81a84990eab 100644
> --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> @@ -169,12 +169,14 @@ int main(int argc, char *argv[])
>                 case 'i':
>                         p.nr_iterations =3D atoi_positive("Number of iter=
ations", optarg);
>                         break;
> +#ifdef __x86_64__
>                 case 'q':
>                         p.disable_slot_zap_quirk =3D true;
>
>                         TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS=
2) &
>                                      KVM_X86_QUIRK_SLOT_ZAP_ALL);
>                         break;
> +#endif
>                 case 'h':
>                 default:
>                         help(argv[0]);
> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/test=
ing/selftests/kvm/memslot_perf_test.c
> index 893366982f77..989ffe0d047f 100644
> --- a/tools/testing/selftests/kvm/memslot_perf_test.c
> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c
> @@ -113,7 +113,9 @@ static_assert(ATOMIC_BOOL_LOCK_FREE =3D=3D 2, "atomic=
 bool is not lockless");
>  static sem_t vcpu_ready;
>
>  static bool map_unmap_verify;
> +#ifdef __x86_64__
>  static bool disable_slot_zap_quirk;
> +#endif
>
>  static bool verbose;
>  #define pr_info_v(...)                         \
> @@ -579,8 +581,10 @@ static bool test_memslot_move_prepare(struct vm_data=
 *data,
>         uint32_t guest_page_size =3D data->vm->page_size;
>         uint64_t movesrcgpa, movetestgpa;
>
> +#ifdef __x86_64__
>         if (disable_slot_zap_quirk)
>                 vm_enable_cap(data->vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_=
QUIRK_SLOT_ZAP_ALL);
> +#endif
>
>         movesrcgpa =3D vm_slot2gpa(data, data->nslots - 1);
>
> @@ -971,11 +975,13 @@ static bool parse_args(int argc, char *argv[],
>                 case 'd':
>                         map_unmap_verify =3D true;
>                         break;
> +#ifdef __x86_64__
>                 case 'q':
>                         disable_slot_zap_quirk =3D true;
>                         TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS=
2) &
>                                      KVM_X86_QUIRK_SLOT_ZAP_ALL);
>                         break;
> +#endif
>                 case 's':
>                         targs->nslots =3D atoi_paranoid(optarg);
>                         if (targs->nslots <=3D 1 && targs->nslots !=3D -1=
) {
>
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20240930-kvm-build-breakage-a542f46d78f9
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>


