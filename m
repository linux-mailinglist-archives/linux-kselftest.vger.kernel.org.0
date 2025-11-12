Return-Path: <linux-kselftest+bounces-45405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB75C5200F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CE918970E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE430F55F;
	Wed, 12 Nov 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQVxioWc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcAd8N0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE430FC07
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946897; cv=none; b=GWnWBHOZ2ENIrdofGvbVhp/OzoVxzxDQxKGsEuBIKDXwO29BkTh9Y1du5kD0L0Ur73+cUNZbAnkH3+SOtALaYEQXAobMjw9cai8QKDTInKS2SKu4KVM/MpmNOihPA2i+tfbLBuqbZ1oiwxY0y1hiJc2id/QIZGBSdh7XECsapr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946897; c=relaxed/simple;
	bh=w9b2RxEPIpBQFFaebpQtwOH3HfQgFg+EyEqHMhWr7p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZrFzv7IInwJKh+qeMp3PKzTJxExi6pXqn4t+NPaMSHmGXIH7EPx3Dy0IhDANHQBs3uTMno+RuwWcKiswBU5LukhXTOQKW8zDt/4ENzuk4oaoVa1mOKqvqkKUpQy9r+BX7XlCzoNsUyYpePgzUqyIEImJzAxB7ijPL8y3fBdX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQVxioWc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcAd8N0D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
	b=jQVxioWcqTqSRT9YcOr+iMl0pjlcqzaEtV4Gtrs5FzVEnclIVWc0XjK8hfXP6tqpBQBV30
	A5L9V0+4wxH1E2kEycn660zdD0UuT5n8M1Zp0RVcfMsxr0jdZlUceNkOR9kzbA/4ctke8g
	dGfO41ZS35vIJvemyWD9gCEArD9dmS4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-KpxaGdeZMfCS6RLrl6YYJw-1; Wed, 12 Nov 2025 06:28:13 -0500
X-MC-Unique: KpxaGdeZMfCS6RLrl6YYJw-1
X-Mimecast-MFC-AGG-ID: KpxaGdeZMfCS6RLrl6YYJw_1762946893
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88233d526baso22274246d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946893; x=1763551693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=UcAd8N0DErhar9fdaQ1F4OZvc0G/9LAs90XoqqiIbWoJH0uZtg13duTIZvta02E2Ek
         DNkdX8YCAy/7sUjbliF4Q+YEv09aTx47g3wFEI2kbofCZZEvREnlrqXbwUybF70bcq/I
         FwhfCScCXEK6gpUfdlQgrATTnkq/yoCpaOiJ4KkIqX86YAGfc4Ktb6hf0JeU5JyPY568
         nKYiZUMrcHZY1k/b4NcrgTSEyE/NdXrDnOy5+yhTcTCXp0sXvxTWGdGRJyEtuL1i59cS
         OzMGdDgR+DJ08RZsDDl4f1/5exMr5xYUtjo6Knj1Gki/qcYtt3DnYoX7gIfRYZTIU34d
         iCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946893; x=1763551693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=Mecxb+RQr0FfHPq7/zBJPpFDMn1WUA9+dqks/Me43w77vxHlFUpnx4NZpz1GIL9iRA
         SKC0+/lD0nyisWiTsc90v/dL76WU8l+mkjdekEsYEAFCooRtSfFdyhayBy5PMV2M2o4V
         8ZTvgBBV/Jiuv7l43E1ILjVwgB7IAK8uM+dmnWeAm1+IlUQhpmbpta9MGIPZCKHrI1wG
         GP9ogQ/iKDbxPRslbvrUysaBVQjNTv2k6bUWrFuEp85RTDX3RKmXIYnQsMqeA3Cnr/Bw
         JQc1pjNIxshcDkUn6Wi2y+x07wIvN0F+aVma5aFfv0Zc4xa/6RK82ayMsF6L3iHNYJRq
         L4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVA6P8XtRy8AB5si7PAIhkvgJ5CsJqJBJSFhMS59KqyIMDk5WXuBeliP0R+LtL/Lvn5eDd8tcf0tRPREElyodc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjMN6DXHxL0AEP63D0JSYjLEMpXkpIXLmip76KIu8c4SN5DZD
	hZdLZNfWaNKc94RBIAVq5VGr6oXdShb/zbzfE+YnhwMFVY36hTpgqqYmhOQAmOgQMi87RsDdQBy
	pAbSK2Gb1wtvGPpnWo8GXp1S6zf15qg5OXFNJM5j1U+EhtwAEJdSrv756txye1prlaxHtGw==
X-Gm-Gg: ASbGncs7ry8tpFDLFz3gJ4thCJeFcPRJr2aloyASBMKXQ0AxLI2Tmvg5Iijx/C3MeTR
	BJ8jBtpWocTRBwRkkcCm38EJ1cpO3xeZ4a4YUuP1IQGKZTUVU46U9uCv2qlM1fS1DrPwo/4NbLG
	iJAsqNzgTXGZjPXuoMta7xohqYOEb5FaDHzgIzg1rw0swDFomO3KYiPc+MNo37WLVkHVdhk59d0
	dF1dq4kpAyyr5OWLy1+ov0zxRRd+8idlPrjUGIlslWYCao3uIt8I03ytvRRxThfKtx7crJdN9/o
	gc6h/POs6Hvh/dsg7MNmsLgOywEXgTV+TwmqHLzcHC5ET2n8HGgkuW3ZOuF0FG/rcCyhajUaxps
	amXalGufMafi/5S443rl/GkOEKbU/VqFfmMrknXTYc/3ZrozIv/k=
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36353016d6.35.1762946893353;
        Wed, 12 Nov 2025 03:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnA7ozYlvXHQMnpycDhkhnMaFa5erx7IOPg689k7NBMlvaatOo3MEwHXk4xMfYTAwAfX3oqA==
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352786d6.35.1762946892999;
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm92866156d6.17.2025.11.12.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Date: Wed, 12 Nov 2025 12:28:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Message-ID: <r5uyojkue5zgoiixgmrjoew6pe6p7jzhd4hsudoxdirwummht3@fclnufaabg6g>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:01:03AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Disable shellcheck rules SC2317 and SC2119. These rules are being
>triggered due to false positives. For SC2317, many `return
>"${KSFT_PASS}"` lines are reported as unreachable, even though they are
>executed during normal runs. For SC2119, the fact that
>log_guest/log_host accept either stdin or arguments triggers SC2119,
>despite being valid.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 42e155b45602..c7b270dd77a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,8 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#
>+# shellcheck disable=SC2317,SC2119
>
> readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>
>-- 
>2.47.3
>


