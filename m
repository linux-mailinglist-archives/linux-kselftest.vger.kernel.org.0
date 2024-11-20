Return-Path: <linux-kselftest+bounces-22362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80749D40C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8843B2D33A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A515098E;
	Wed, 20 Nov 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4kQaOvR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B54482EF;
	Wed, 20 Nov 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118179; cv=none; b=jd7B7Gy+zElvb0X5MB5LrnGnzik8AooTMm6pCOt9OGh1of97fBCqfgxJ7nRdwAywsPVpVFISLpEekiKXRY0qtDrtD2rGHR3AGw/lFrhCOHyoHsNYyc67M+/l2OytO3pdCvllHy8aoj39WbZSDToZfgGIdaNQUj361g//kV3rz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118179; c=relaxed/simple;
	bh=odxh1O8sYaBXlTCV5VWBnFUkceLn1wmJQ32B3envRV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Yvq1Df9U6tvzQs5VZFfm2R4JyNBORLXVBxRKQtPxWUbF4646y0R8O+lvSfvP2RZghPwsT5oEFKXXH0wjpnUml5qSO2diHZhUorXpguEvtFD6DFB02xudbVDe9BWNDxp5Ej7Fkxfn4BTJVws4/AvmtP5T7CgMRw+XVAeltPr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4kQaOvR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3765684a12.1;
        Wed, 20 Nov 2024 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118178; x=1732722978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u1nf5X6vhX4nOgwl5tzo7301CPOl7HpWw/+s1b3KJ7s=;
        b=P4kQaOvRdxkIW46A8qSAxUqz3zjEbPxbSI2VAoP0t0Ksyx6NNSqiBFPCSOmnKgM1Pk
         +NZzi7PvUVPv/79/CdnJ9N8zCp4/lZRKkBm4yZU5i755Wk+AcJlYGLMR1PZLwcXWskue
         d32ts0kZTf0hY4RqZaiK/3uLqhdU+u2Dk6SEfYmSosyiO0V1FbaF0V3b8hC4YuHHAIrB
         2XOqX3BEm0E1Ni9A4IpciL3SbRsXCyP8Qy8M4hYjzGt2LE7UpVqk9Uldr4KVFytVh3X8
         Q534OfXkag8dO2aiUbnDfARZnrn1cDKxI17XIRpBCSjo74HpXjzDooJadWrL/8Lu6Wp1
         lWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118178; x=1732722978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1nf5X6vhX4nOgwl5tzo7301CPOl7HpWw/+s1b3KJ7s=;
        b=w6e+7CJgJ79HRXswYNzVU5oLhhrNn6aqG9/Qq+1rFNeDI5kJcVcxr2InuzjmkA/V4f
         RTU2VfcEik1p0MFUFTIhwR1+1NrBfIjzF240jc3+0yXtHTF5S3TpVg/Srmdjv+mcL3sk
         mpnwGURtPESZRNwpyRMbSQU1l7am6QvYb/FXa4pBeVVmlsgQuYjSEbaJEv46dFmgHANe
         S1SFMxUe75ECPMQqGrcbQIJqWVQz7s6eCiaw99UEe+5gTDPC7AkVBsIvH15y2qAUtt8n
         x3RijWMzA2Yt7BPw7OFVmeNbuFXomt0hP8R5PaE0wt7vF1SOQgGBI2g+/M6Kd1tt9dSD
         6rNw==
X-Forwarded-Encrypted: i=1; AJvYcCVEOAzXCymUOlegcEgupzcW0NOf2yzM7vI92lvFWJkWAhUJM83V9+FqH7ONGGZGQl2y6yBAx9jWspOtvW20@vger.kernel.org, AJvYcCVRZyKGq7ECcRt3PTsrUrRQYf7a71H06Zi5Hgzuo+sdXAMwH09heoKclFq2LxYFtCtGYIuRLTae@vger.kernel.org, AJvYcCWNJvy/L9F9e5cMUqa9N9eEtP6wSojQLQS+zql1LrOdgm1RL9K/ikwum63j/4DgqYqf22tYAkTnwuZEh9LSpY6e@vger.kernel.org, AJvYcCXrccE08q38U2wb6x317XORiOjJiPn0oxek8GRrP27gMq80BPkL0lPraQmG9ed8WU708CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt1X5yOHvCi780PEoIvLKHKK9oHo2AAtrI+wMzFTGGPpWw7xq
	QYPg1W6iamZ10srX6TWm1cqxXZE4HxL7j+YcUptVMH2Yy481iJY=
X-Google-Smtp-Source: AGHT+IEP72FX2YezO8seIUdQnfo78xPLL3gwt1XYDtelmvHl2jy/UQwa26DQEhEViKwapnTmel83Lg==
X-Received: by 2002:a05:6a20:2d0b:b0:1dc:3024:5edb with SMTP id adf61e73a8af0-1ddb10e3497mr4221378637.45.1732118177892;
        Wed, 20 Nov 2024 07:56:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befea7adsm1851567b3a.189.2024.11.20.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:56:17 -0800 (PST)
Date: Wed, 20 Nov 2024 07:56:16 -0800
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
Subject: Re: [PATCH bpf-next v3 12/14] selftests/bpf: add network helpers to
 generate udp checksums
Message-ID: <Zz4GoCSLbfW-SauP@mini-arch>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <20241120-flow_dissector-v3-12-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120-flow_dissector-v3-12-45b46494f937@bootlin.com>

On 11/20, Alexis Lothoré (eBPF Foundation) wrote:
> network_helpers.c provides some helpers to generate ip checksums or ip
> pseudo-header checksums, but not for upper layers (eg: udp checksums)
> 
> Add helpers for udp checksum to allow manually building udp packets.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

