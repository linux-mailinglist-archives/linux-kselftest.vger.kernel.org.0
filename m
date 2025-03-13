Return-Path: <linux-kselftest+bounces-28946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2DA5F502
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D702189236E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A42676C4;
	Thu, 13 Mar 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yj9m9GR8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E0266590
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870614; cv=none; b=c39zUkXcgPUTni6xYPIdvgfRSdqeqt7kPfNblU1JCdRbQPeT9WvUh+CggwFiLzjn8yIGsOPgbXPxEEAmUssT03Jqsd0fY3OGoDG3fjTSoYNQafdD60Mkc6ejWaIXh9D0jEuoV5krqJQ6SdFP5b44uVQBIpQWcGjvXU2poa9ID0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870614; c=relaxed/simple;
	bh=sHZbfdxQGp4mdAR2Febo0n1NWIDVS+DyHzbiuUQ0mhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgCqM2NN6qhqdfnQfqMVaV4wd6/3KmcNy4E8Q457EZo+3SQciMubH5YWIrVnosMe51gaFVAS47DnrpOTuPKsjJOH9JIvbGYKmQYqEOAWf50JrqFZ5uYLiwetr1ct2Ry/OwgMpdoJC0X9XNTfXMI7pElQUuYvblNyosoXm59BE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yj9m9GR8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741870611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+f8njczfxaG2co+pkvStJWQ0iTaUQVmmbS67uxHnnY=;
	b=Yj9m9GR8/DeqMJHlJqjFRBflQGVKeBgAprsu212IAf/p2TzP6L51LYpXyvAsgdE0k36IB1
	V/AVq+eKTB2OtJN+uigLSWJ2qIi9sLk1cV75o0T6oPVU10Xu4jJ8T7NUvsWGzeJZbm8k47
	hEicZ7vc+Q2sDh7DjSi1yfQ1a2ZtKn8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-_DPZUorENGSOArhF01ygbg-1; Thu, 13 Mar 2025 08:56:49 -0400
X-MC-Unique: _DPZUorENGSOArhF01ygbg-1
X-Mimecast-MFC-AGG-ID: _DPZUorENGSOArhF01ygbg_1741870609
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so4872175e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 05:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870609; x=1742475409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+f8njczfxaG2co+pkvStJWQ0iTaUQVmmbS67uxHnnY=;
        b=t2ISIDGsHEq8poq2Ji9OD2k8Td2NAdVAWbIiP36FabG6hA3FMQR6wm+tX4AiwTcAge
         7aFnhAObASb8GrCwWbX/Jj3CVfXqKAirVnPpt22D9a6t+Am8DcqK1l+t/0fy+5VD0SE9
         QPpWbx13QwaXmONlMwdTKpR+ifyBjDwC0FrfrzYkWRQ16t87/ongqcFCAHX9wgvbKh2J
         H5TTdchQzNm79/LPY2CjOEmSsf8jU1s5LNjeu7QuSgORipp8UoM7CX7s1XM2JuxKRafg
         myiL8H9122Mzv0fHir+lNEwgXELRVztsLJiNYjsMlKm0XaU20Db/R8yAnnBKj6UNhBpS
         kveA==
X-Forwarded-Encrypted: i=1; AJvYcCXnAG+Z9nkCrtdeagVy3XF4SFRt87F5HgUqlI4Dr9wlPMrMlKkTM5wfltQoj4jpkQCaP1h4Dx+UW49BDbOroBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcl4mGr/a+8t9TIghUA3IgjxVTpxFrBG8R7GMQSpRwbAupZzC
	I4Q7rO3Kp64UXWfMVPDawBDgL3WoDh2w+Oo+QWerPUhe1sF5V24bHkkpsVM4aPaWk4kmxtOAg01
	efJ0S+coMiv1On8VD4kkJaz7Mrm2WP1p8cq4M+i230dwHpqjJWdp3NDr78lmYO7uHdw==
X-Gm-Gg: ASbGncv5MMx0vM5BoO37Y2qx5qitask05lmiBDu7LF4I8ZmTrdbma/lmXcCO+jOsQR9
	sNuDlFsB/fSeqBy3T8HAxTxDqtCfYiYUsFLL9UBi1q2dh3+lvii473z3ZrfcjawRtq9RniiXIxT
	jvyH9u+9qYDix3IHsqynPKtw+QKfLVMsFy3wrV5fzSd2wQmMqofhNZiJD3jjp9IsZJJPgznkMdh
	ADxSR/zdKhffG27QspDaxjmKXrM+Adxr3E2nWtTv2GOGAqXktS4hFvUpj718x60icAVIGRpNrUS
	uXe0nsEM26AwSNRwAGgl8HPAxdXPPNUDlsYVMnJK
X-Received: by 2002:a05:600c:548e:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43cf70a2d2bmr157969705e9.16.1741870608607;
        Thu, 13 Mar 2025 05:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDa8ie+Wz/9pwdX9IQXaSESSe0ds+RYH5z8oo0ZoXLXzFF6SIuQIjrJS2rEfZaRhu/aenE9A==
X-Received: by 2002:a05:600c:548e:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43cf70a2d2bmr157969485e9.16.1741870608203;
        Thu, 13 Mar 2025 05:56:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35f7sm2079659f8f.13.2025.03.13.05.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:56:47 -0700 (PDT)
Message-ID: <3c39994e-548e-4d67-b8e4-3236d27a6ca6@redhat.com>
Date: Thu, 13 Mar 2025 13:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/7] selftests: net: test for lwtunnel dst ref loops
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-8-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311141238.19862-8-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:12 PM, Justin Iurman wrote:
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 5b9baf708950..61e5116987f3 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -107,3 +107,5 @@ CONFIG_XFRM_INTERFACE=m
>  CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
> +CONFIG_IPV6_ILA=m
> +CONFIG_IPV6_RPL_LWTUNNEL=y
> diff --git a/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> new file mode 100755
> index 000000000000..9161f16154a5
> --- /dev/null
> +++ b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> @@ -0,0 +1,250 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Author: Justin Iurman <justin.iurman@uliege.be>
> +#
> +# WARNING
> +# -------
> +# This is just a dummy script that triggers encap cases with possible dst cache
> +# reference loops in affected lwt users (see list below). Some cases are
> +# pathological configurations for simplicity, others are valid. Overall, we
> +# don't want this issue to happen, no matter what. In order to catch any
> +# reference loops, kmemleak MUST be used. The results alone are always blindly
> +# successful, don't rely on them. Note that the following tests may crash the
> +# kernel if the fix to prevent lwtunnel_{input|output|xmit}() reentry loops is
> +# not present.
> +#
> +# Affected lwt users so far (please update accordingly if needed):
> +#  - ila_lwt (output only)
> +#  - ioam6_iptunnel (output only)
> +#  - rpl_iptunnel (both input and output)
> +#  - seg6_iptunnel (both input and output)
> +
> +source lib.sh
> +
> +check_compatibility()
> +{
> +  setup_ns tmp_node &>/dev/null
> +  if [ $? != 0 ]
> +  then

We don't have formal codying stile written for shell files, but please
use tabs for indenting, and keep the 'then' keyword on the same line
with 'if'

> +    echo "SKIP: Cannot create netns."
> +    exit $ksft_skip
> +  fi
> +
> +  ip link add name veth0 netns $tmp_node type veth \
> +    peer name veth1 netns $tmp_node &>/dev/null
> +  local ret=$?
> +
> +  ip -netns $tmp_node link set veth0 up &>/dev/null
> +  ret=$((ret + $?))
> +
> +  ip -netns $tmp_node link set veth1 up &>/dev/null
> +  ret=$((ret + $?))
> +
> +  if [ $ret != 0 ]
> +  then
> +    echo "SKIP: Cannot configure links."
> +    cleanup_ns $tmp_node

If you add a:

trap cleanup EXIT

after setup, you can drop the explicit call in the various exit paths.

/P


