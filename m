Return-Path: <linux-kselftest+bounces-20237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E19A5D51
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11501C2339F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68951E0B94;
	Mon, 21 Oct 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq4jHJPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A571E04A5;
	Mon, 21 Oct 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496486; cv=none; b=coEZXlZIjxgW7qIgMWxAY/68p/nl1K5ZxG3GUMn2VZ1yNxUc9DE8xokYmba9Pbd6QlFRVrTmHARKmZIXHL7i+IKXxwRnBGKyeW8z/Ic1ugZk0evLi7H3sYv8kRS4lCt8HEEdYpr+XW9wJTBTxIs7TodjlOVRXN6OtnsM4jE1P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496486; c=relaxed/simple;
	bh=AF/tbeqoppPcHSq02WnJEwEhrIxXk2E6dRGZickPP+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFsW4SxuOgTOiykEWXktmfrbDzTb4ZmCYDrFP2bf/+ooJDJr1CGn0RxhtJAryIbmPk5xV3Qa402o8M0BWNyrjxsIYGfaOqdn+R+dSEmLlfsJyGqKeVZUK8yQx6xcJkadtCygbNTrxHO5bpkOmUJs3IpUv9eoJwHBnY8r7YiwYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq4jHJPX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso571227766b.2;
        Mon, 21 Oct 2024 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729496483; x=1730101283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3DgUAwHGp1ylHvrACNvY7xdDBF/rQq7hdSmsZeGjcM=;
        b=Sq4jHJPXWFXyyckb/5c9vI8McKM52snunEWRjqKkeEIwu5tAGkZLH/usEN+vWb56j4
         BonQN0vmBxjfCZXYbRAIjfwESPegOhbG2Rd/JI2L/ZoHVeZlV0JRMndZkHGZmPoWbar8
         V+9jj/w+fVoYkySSVFpJhaazB1h5e1jeI20parbnT/4KnObxAPohRrRMe749aRfPq0Gd
         nwgWQAHUbIEyKDsA0yX+1z1QMQTh8gfsJ4NXJn01g12NfwiHPbT0u7Pm+ujcOhbbyl19
         YtZqI6S+jiiNMUahdGtk4riduQprw4dWB9EjrmOFjERm6YmZYOowHBUoIkB9IF7yR9xA
         hHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729496483; x=1730101283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3DgUAwHGp1ylHvrACNvY7xdDBF/rQq7hdSmsZeGjcM=;
        b=tnnP+VnVI8XgjrZJTiGFRVRorXqEOcQTGbUXZ9BW+aoTrMGbb3sNyPL7eFYoVgEULV
         R6Z4oANhR+375xKQNMCi2U3cyPh70pZlYUuvINmjMtnEt8Xa9dF1C2UZTAQ0yaeVFVjK
         tVvNpHG1vF4WvgmkxVq9G+zq9SeEzF+aJmYayyVRFihtMAEU2MQGf+Gr2x0PfozLdoFM
         +UKt2ooKCSRotQDVG3mGq75WHKSoN6H9TqlbixHqEW3k+nrQWsDEuq6Fp9y3PB99+qw2
         wQykTNhRm30fNVyXrDSzzCGQ0NCFpDlTU0JdMoAvg2AHTaXJNI3i3rQxLklh+ZIbFodu
         cebw==
X-Forwarded-Encrypted: i=1; AJvYcCXMyK0IGGVHAkHPJNmHxdIL2jFS32Z3Y4Od2wn+qsby1ikxILlJ8xv1HhdlCzJ0WXZc12k=@vger.kernel.org, AJvYcCXVFuHWVvWUuJZery5TOOtUL36DQPANkSclO3zsqzk3ChTiNjZlovMdHpXjy7mMoEIxkh/EgeOde7JYkyeXUUrN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh09EfdlZE2C82AFNOX2wDRQgPlpJjq2UGRCM5LFUqmdg4kz6V
	rnHV+XFeVDzW2E05/O8cHZUqvHEgE9jWnY0KZY7Cni8p/O1NhKRI
X-Google-Smtp-Source: AGHT+IF7XOM4S/WeTzS1fsASv+aOkD2OCEqGxgPjQ8cOLEgniqdobMUU2CUskDtdSsh1Co6hPV6IaA==
X-Received: by 2002:a17:907:3a95:b0:a9a:80f9:d4e0 with SMTP id a640c23a62f3a-a9a80f9d8bamr526312466b.34.1729496482617;
        Mon, 21 Oct 2024 00:41:22 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9155a871sm171134466b.111.2024.10.21.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:41:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 09:41:19 +0200
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in
 uprobe_multi.c
Message-ID: <ZxYFn7fko5C9BnHe@krava>
References: <20241021050706.29403-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241021050706.29403-1-kerneljasonxing@gmail.com>

On Mon, Oct 21, 2024 at 01:07:06PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I compiled the tools/testing/selftests/bpf, the following error
> pops out:
> uprobe_multi.c: In function ‘trigger_uprobe’:
> uprobe_multi.c:109:26: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
>    madvise(addr, page_sz, MADV_PAGEOUT);
>                           ^~~~~~~~~~~~
>                           MADV_RANDOM
> 
> Including the <linux/linux/mman.h> header file solves this compilation error.

hi,
strange, uprobe_multi.c even has:

#ifndef MADV_PAGEOUT
#define MADV_PAGEOUT 21
#endif

and '#include <sys/mman.h>' should be all that's needed

could you please share more details (extra flags) on how you compile?

thanks,
jirka


> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20241020031422.46894-1-kerneljasonxing@gmail.com/
> 1. handle it in a proper way
> ---
>  tools/testing/selftests/bpf/uprobe_multi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
> index c7828b13e5ff..40231f02b95d 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c
> @@ -4,6 +4,7 @@
>  #include <string.h>
>  #include <stdbool.h>
>  #include <stdint.h>
> +#include <linux/mman.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
>  #include <sdt.h>
> -- 
> 2.37.3
> 

