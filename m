Return-Path: <linux-kselftest+bounces-26810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50069A38E23
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F2617297A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4091A76DA;
	Mon, 17 Feb 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbWICnnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EED1A23AC
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827980; cv=none; b=guOhYGRD+qtVX2C6rkhi51bd3DsiSziKcFJ/d1Wr7lrok/lPJ7tZz1mpAQGu8jsfLinIgU41a8nd4Vb5R049/ib6ohwcOQ+ep7QnFNstzTG3bhHOgn/kZErRQ4zV6MW0ZnZ2EMnEyBdrtR2Gk8ewK0uXCeyfWMjKqlFjF2Re5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827980; c=relaxed/simple;
	bh=UxRYE+GnMEXy65wJRre9vuUKgKVVkSZiKNCcZ0lZ9aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVHkmvD77ojkJGrtoDKOTUt71Hq5lDDlvsB4stgr+XLWHKmVUU1SkJMmO6pARL32+TIh05W9F7gGQrqrO9S3LdBiMjeyrZsvhsCSmHSxs8xZPhAEY4UZAX9ml5mlv/BgEaH9cLv6QF9rZzNMc4oJom6SHhDZQG2QJ4TKaO0RvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbWICnnx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739827977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wjr6J6DOeZeSoS3UpK+LIJot/A4kSVDwCJKjvWd8g2s=;
	b=ZbWICnnxxESrpvcSzQmZPtUxUBiBVoHBmr18ldAxk1xNQepSGrGPshmNbSYItkMwFJrtIR
	2A+QrpvCOfmO4GRjqObwo8wG0GPDC7DFfTOqwTWVQ5M73rTLXLYtQtVfbbuZz+AIHyTJa2
	3KjNdVnZBAF7zjm4B7HpvJC7vN2Tyyc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-KXRgNo0sMpON7LaLN3QQxQ-1; Mon, 17 Feb 2025 16:32:56 -0500
X-MC-Unique: KXRgNo0sMpON7LaLN3QQxQ-1
X-Mimecast-MFC-AGG-ID: KXRgNo0sMpON7LaLN3QQxQ_1739827976
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e5dd164ee83so2372481276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 13:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827975; x=1740432775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjr6J6DOeZeSoS3UpK+LIJot/A4kSVDwCJKjvWd8g2s=;
        b=PnqFtTfsd5JfiLvtf2EHGoo+yDtVXw5JsdUFsIkWH+sy+tLizUO/TRThLawp/AMMp8
         n12Nr12pLlfBFaLRcArPlTDQ+T7qmu+3U1azOcGuZljdK2eS7BZHoyD2MIotIFTPHz6G
         Qz0clQsjOL8b1ZNgrSJYRRNQi1i5Gk1fHEGfvKNl2ur/rVLaGtbFQKCkPZx8l8va3Iq9
         9D08ru4jugw5swh47ZIPO+Tgje2FXFttvSPy7gEKm6XIQbOvlgRrMTJm309bnutSTsI2
         Hi6BRxT6UIhqJK2OaNw12DaK9XB1hw8/PaEX2RNF9R+4VqILk3eiQdU1zyBPlIKU0abZ
         9++w==
X-Forwarded-Encrypted: i=1; AJvYcCWHhHxZj2FFx/FPoWiuvNlQsLByZsoN+I4qOrpGioDGaSqjgFXXcT6ugv6pfF0aSehKXpv3+4eE8nu6jHJK1zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZrKVubk4WiuadNZF/cxsn6YlDuQF5Q6pNLlnNGiQL9iuAMs/
	yXHUrjB0Dhkake/irEJDDC7waBZJ1nsy6Ky6ddAvMXHK12PX6xmQfDIif6POqs8LZTY8fEsx8hg
	l69KTijfYOp5/SV9rDcOECkXqokAlSGE1Jp7E8k7gTH06jnuNM0vlx8Hr9vmVn4RVPnZxzg8dn2
	SglfR7SSWuwjhHYPvi3Q0CjrUXy57VHbOD2HAPPuM4
X-Gm-Gg: ASbGncv1hZlDMNrwoYcXbmcSAC5SR8FtT0ONoggYqCxxczUTQjBJGvMMF88s2IOpLh0
	p7d8nT4Vag4XnCxw/sH4cfpL8X7EVlZmH7PoxCFqPdDa/SMo9bSXxJkD3txWInj+DvQPJwVtsEY
	Q=
X-Received: by 2002:a05:6902:2102:b0:e5b:45eb:dbfd with SMTP id 3f1490d57ef6-e5daa4c6821mr16623484276.11.1739827975043;
        Mon, 17 Feb 2025 13:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOkZYdxA7+HLOKnLODZz3B+t380yGAD+5tVKQqEu4d65LXrhAQ59NLa24+U3g/GCY/e81Og/sTryAx1QenBGY=
X-Received: by 2002:a05:6902:2102:b0:e5b:45eb:dbfd with SMTP id
 3f1490d57ef6-e5daa4c6821mr16623479276.11.1739827974804; Mon, 17 Feb 2025
 13:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org> <20250212-kselftest-mm-no-hugepages-v1-1-44702f538522@kernel.org>
In-Reply-To: <20250212-kselftest-mm-no-hugepages-v1-1-44702f538522@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 14:32:29 -0700
X-Gm-Features: AWEUYZmwEXuqxVjY66-BVM_Ib4FZYHb37Giao24vLwf7Z76BXTlSrlgRvS3mTD8
Message-ID: <CAA1CXcDL+WNnn57dDQSLVkHNr46hJZf2PPTO-1zgesc1j2uxTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/mm: Fix check for running THP tests
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:52=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> When testing if we should try to compact memory or drop caches before we
> run the THP or HugeTLB tests we use | as an or operator. This doesn't wor=
k
> since run_vmtests.sh is written in shell where this is used to pipe the
> output of the first argument into the second. Instead use the shell's -o
> operator.
>
> Fixes: b433ffa8dbac ("selftests: mm: perform some system cleanup before u=
sing hugepages")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Ah I meant to use || which i believe also works in shell. Thanks for the fi=
x!

Reviewed-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 333c468c26991421cd8f9ce6d995f9b64b0643c7..da7e266681031d2772fb0c413=
9648904a18e0bf9 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -220,7 +220,7 @@ run_test() {
>         if test_selected ${CATEGORY}; then
>                 # On memory constrainted systems some tests can fail to a=
llocate hugepages.
>                 # perform some cleanup before the test for a higher succe=
ss rate.
> -               if [ ${CATEGORY} =3D=3D "thp" ] | [ ${CATEGORY} =3D=3D "h=
ugetlb" ]; then
> +               if [ ${CATEGORY} =3D=3D "thp" -o ${CATEGORY} =3D=3D "huge=
tlb" ]; then
>                         echo 3 > /proc/sys/vm/drop_caches
>                         sleep 2
>                         echo 1 > /proc/sys/vm/compact_memory
>
> --
> 2.39.5
>


