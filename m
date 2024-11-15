Return-Path: <linux-kselftest+bounces-22108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18509CF07E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF021F23839
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599971EE037;
	Fri, 15 Nov 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NisQIBvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFED1EBA1F;
	Fri, 15 Nov 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685062; cv=none; b=SRdZ3LKdDsabu7ilXgRPR5a//OhTezHfRkVJcEBKyDOfRBSG1/5wbIl22HlNqeFVLRqn3cuc3s3lP+MxSylmpN4+KKA604R1lSx5rTC+eopVV4ttxaQk8SIydqN1yoeIgBsthcT03+kzl4pXmswRuC7Mbvpxt9Kq/yN5kYwaPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685062; c=relaxed/simple;
	bh=0PVblsDRA77Rnd2SrDeXPvCj+AkYyXnR7eiruXvE/HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGd6osXd7lL8i3GZ0rZz4grVWErChkDtzgVLdS5TF2JSz50tcimC1njc7LRdFmytsGXxu2IhatN0ftycljYuclNJ9m6v/jnlSys5tyiUGWm7mZjTvZFH3ApFKF3YA7tPN4KsvgJlFPvvm9gMm/Cok+YaTm+W8BBcSbL55Taq3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NisQIBvA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1467302b3a.1;
        Fri, 15 Nov 2024 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731685060; x=1732289860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yoyUygnEDqv1sl49POhWOJmAGKIKRSGhPgMfHLTPEPE=;
        b=NisQIBvAxiJdztkC+owfSqEq/Q7jFIdF/rZVDxwMkH1IuBYc8S1faNuSUkEb5IaT8k
         hnFXZnk+34+8P+6TSON6hJJ33FJU5BHMntuvlAK1WAc4RsQvcT+w227RXF8FbSUZifix
         tGlVKZhjwuWQ96HxqEPfE3mKnvKkRoi/0rte1Kf7VzHQKFIHBE3dWv+0kZnjByxLEWB8
         L7C+G5CjpJvS3Xx+gkUV5cTXh+FF24kju2ySzqjeBT9AAkmjhj+wPWR7amB1WEY7JV9Z
         2JWxU7+c5+oaDgCXxbGaHuGLgZgAkFqY6WAxwnw5rakGNoPqkZHj0wYTetaZ1W/raC1C
         Nr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685060; x=1732289860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoyUygnEDqv1sl49POhWOJmAGKIKRSGhPgMfHLTPEPE=;
        b=YB4lyFcD/mtVFssmp9fSRsYY1GYyf9zZwfSFQ8Xc17xNRVqMyjsO1wVwxA4DKjN/Xj
         Se9OxlTMnVITHlIgRjwgCIeatEkKmvF+SCuxc1Hq1qh6RsdAQe71mBIKRDOmhAi7Ld0v
         dyJLG+PjO2mfyG2gvAbJy8ve5KbVg/8Mw7DFFkkHgXGzb6DqdZb9oSpLaYH4XHyF+ixa
         kXVV193dtLjsOwHLvQDfFpMUFeCqln4WFUdE9KIbbSV8I1/yAy4tpIELaFAPp5gp/nSy
         ITaTGK1elR/YG64R0O8On2ITKhU2RQnP5QE8jXfg6m/O74iDSrMYNd6wj0FmIeQqisQK
         D8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXmxPBA18uUAilA9AKcxrLT39Dl6t2MtIAn095FN47C2zHGMcLQLGQkQedUmMCV4Vzuy4uMXR5yVcsowRP@vger.kernel.org, AJvYcCUcnTEapeEq5c+mhfg0xX57kBaAmYrUz4qfjc0sJkYC7HKzXO6fESEuy/Ul3KpLVGe9gLE9vYen@vger.kernel.org, AJvYcCV7xNFhnjtJzdu0MRkXWCEuof9mtNhklCnH5Pyx2CKSWnkS6yPHURDJQyQx4T9ham5Ttmo=@vger.kernel.org, AJvYcCVqFdETeZlL/cjLpoiMhhhherW32iec/SULCSRf1fdJUuHxhr6YsFxsvTn+QXWy6x7oWwXVkQQJltfDC2dv+MLg@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhTH4pH7uiZZC3su9d/8texlQ/NBuvtvUdDQYPCWmnciu7LcL
	HJgMrvX6bZish+hK+1j7MbZ6jCZdFiM77WBEEBAEDBwFtLds+7Q=
X-Google-Smtp-Source: AGHT+IHjSlXN7KUkjoVV1B3vVD0bH+j46ZLfV51KqXZZw3ZV0fV29iOjgmG5+sYvHxdQbvdFhcaMSQ==
X-Received: by 2002:a17:90b:17c2:b0:2e2:de27:db09 with SMTP id 98e67ed59e1d1-2ea1551cb1emr3594710a91.19.1731685060008;
        Fri, 15 Nov 2024 07:37:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024ee436sm3017381a91.47.2024.11.15.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:37:39 -0800 (PST)
Date: Fri, 15 Nov 2024 07:37:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 01/13] selftests/bpf: add a macro to compare
 raw memory
Message-ID: <Zzdqwn-vhYxWIXGo@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-1-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-1-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> We sometimes need to compare whole structures in an assert. It is
> possible to use the existing macros on each field, but when the whole
> structure has to be checked, it is more convenient to simply compare the
> whole structure memory
> 
> Add a dedicated assert macro, ASSERT_MEMEQ, to allow bare memory
> comparision
> The output generated by this new macro looks like the following:
> [...]
> run_tests_skb_less:FAIL:returned flow keys unexpected memory mismatch
> actual:
> 	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
> 	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
> 	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
> 	00 00 00 00 00 00 00 00
> expected:
> 	0E 00 3E 00 DD 86 01 01 	00 06 86 DD 50 00 90 1F
> 	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
> 	00 00 00 00 00 00 00 00 	00 00 00 00 00 00 00 00
> 	01 00 00 00 00 00 00 00
> [...]
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

