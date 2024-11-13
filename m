Return-Path: <linux-kselftest+bounces-21962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B19C7A47
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE0C1F2354C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E442022ED;
	Wed, 13 Nov 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhjiuYhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB51494DD;
	Wed, 13 Nov 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520267; cv=none; b=aJIYG8m07hJWCiyj5ubI+cUqqH/stmCUUj/LmUJjSn4jVK2BeYVPoAUxVumfjjcrIKbWHQIOiauArnxw64Ii5a2yiGetoH0FjDavyWRd5CWrWMgr3VMSRFgB5wdZA04rUF6Bde1H/ZM/b6iElKnPnsIXnttJc77qq1ophzxTRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520267; c=relaxed/simple;
	bh=cgqSQ8xsWHXRGC0MqikHOjOXkKohYabtUMH4O6rqTqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyCBcxK884MqMr5ZfYRqdhVtyc7lqezkjQRjs5oEtr519xLIZ1Npjs2Wi4YVGbrCIToX1jC13r2jHjrM1tv37ZwdiNy7e6koijkhXTI6uXZ0CodDDbUp1zxPgMTSdibO27BcZEj1vZ30zoSjaqJYPiDt2g3L4Irl7L6XJC6Nr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhjiuYhI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so5465913a12.0;
        Wed, 13 Nov 2024 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520266; x=1732125066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6gtkvcCPZ9I0VV3HqGxEXwX4IHpcNbFDVKM5W6x9oc=;
        b=PhjiuYhIKeUrBW/U067y06mpj8si2FwNL+8B22A6Io6ms6FByLMOu6Zlv2egpSwmuN
         MSzG3IWARyBlRh+T7Mc8B1j0lgfHgfuHpRL5dHW1vVYtksEWUTSBAFMKRc94udChcAS3
         SydEj/Ly31RgUDFZ2rP0CqDzFmmN9e5fFtBXM0D6plnep+KYELCScD4W0vdORfJUCtY0
         pr+P2StVJDa9tPk4QsSfNGIlosH+dCDUqJGa/hf0O41WYs+Vop/EU26ftwXftRa41PKN
         ilvRaYYMJiIevDRrmokl+jBJLkPIvP2sWHKwot/+MHK3QAQQcwRbbHGXPnVCxegutuM1
         Pluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520266; x=1732125066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6gtkvcCPZ9I0VV3HqGxEXwX4IHpcNbFDVKM5W6x9oc=;
        b=XSo8o0+z4n9rKReAvwox4MPHPcs6LiiZzTElw8AAGN331IYH/9LuCyZE7PmrinMfYo
         v2AB/lO8S37T04L/363rOy7UxkFi+/EJ5iZLAuAoz2kSLbxroZM79AphjOygXJD5Rd/X
         1y1sibTsSvOXLBCmHm/aPgTKh921offkbTyL6k+nUbcjMEYe6UTvOGsZibD6AjBxyHbA
         GXvKKlH1ZMMrv4DC5cGVzrC7cH6j/buiASL5kO6SE4WrlBUi2hZNXG8AWXlL/vCgpfSG
         N3W9CaBteTdRjjHbOb2PLkuq9mA149bHz/cwPIfjYGg3qY0EZvTmeZ5ZOZZN+2SWS+aw
         T1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDHlROpax0FXUywtk2wfknOAUrTi4NWMIeiX7u95R1TbMfp7znJajrryOIuv8QtCjH4ycitlUuGgPQPQD3+SHR@vger.kernel.org, AJvYcCWK0Ys7IEg2qhsg74W6AYwFLmD/ys3i/BPKn/FeSAKFpkoGp3yCKjUIfRgEnWcyqM4XlT/pLVeijXjbnrfj@vger.kernel.org, AJvYcCXRweiyFkzfqZN420i314FoiQhinNS03Zk/l3qbcLLpeeAEqMLHtyQ9NjZbHr1AQSFO6oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UjQyBGEPvhe/7weoX/jAujhfmEJLUGLdQr6kmR+uzmTPFYO5
	Dy+96pd78BduV01KGATUxrSnkfCkehlt17P7VZXAFFQWhUqbUks=
X-Google-Smtp-Source: AGHT+IExNgKfZuMC+us/QH4h1GKtke20sX75DpAwViqqCK1JuaDNhybMuTDWjUF/HDbeQAF0/19nWA==
X-Received: by 2002:a17:903:230a:b0:20c:d1ec:aeb with SMTP id d9443c01a7336-21183cbb269mr279382965ad.21.1731520265693;
        Wed, 13 Nov 2024 09:51:05 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9073sm112513715ad.1.2024.11.13.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:51:05 -0800 (PST)
Date: Wed, 13 Nov 2024 09:51:04 -0800
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
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: Enable generic tc actions
 in selftests config
Message-ID: <ZzTnCKwdkSxiaqJe@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-8-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-8-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> Enable CONFIG_NET_ACT_GACT to allow adding simple actions with tc
> filters. This is for example needed to migrate test_flow_dissector into
> the automated testing performed in CI.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

