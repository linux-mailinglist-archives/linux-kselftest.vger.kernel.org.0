Return-Path: <linux-kselftest+bounces-3208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D5831D32
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D3B1C22C35
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5128DCB;
	Thu, 18 Jan 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB4YVA41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6F1E4A1;
	Thu, 18 Jan 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593954; cv=none; b=lG2+0cV1msaYeHNmWId33ndvK1dQJQyUCvLQcODl1PBiGiB/rJwz2pvGM82Iv5dG1T8CF9nvvQlZIPrnpyITAzLnMLeJmQo0cTCqjoda0dDKCLLK4GeKf7apexiWBv7Wmpj+4RsAoC+BgYFglrLvc+0UC0mHtUr0kfhP1JMpVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593954; c=relaxed/simple;
	bh=wyqG3HNRtLtdXhdqJhqXHf+h1pw8GhH6LaOIARO7qyM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=cZRzb1HyiTm6DOAeR8rR5jfIL/cSsV2HmMq7KDVoePFB+C0Eenc+qlpnu8SmMFHbRl2JmiKJrr8e33Jbnul0zPro24azewWnmXPABHfidyRKIgOM0+CS/HcJ1drAwCqf9jjPm+F1Ur4py11w/+fYCQb2TxBg41H0qrbBdcojCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB4YVA41; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336746c7b6dso10667540f8f.0;
        Thu, 18 Jan 2024 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705593951; x=1706198751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewpSOiW9RlGueTIhRS4yCwW1pNfEZiBqcXxXwqJipKQ=;
        b=mB4YVA41qlBB+lQYFpCLxrLOfHw54Cilf9u4lgsHUSkaeVykw3Km+m9LCu9KPTx4Pi
         L1XgDTtkDQnfMZilh7feDLcYMMMhsmy2+rPlg4tdyXWPgYZ/PPwdaf0djMNrPUa40hBN
         QlQ6ASzcd8kKaukOTbO+bv/qGKachqEAwBzelMtZfIZ76qT9ulxlyns9nr7o0u2cTZe4
         HWEXOYr6jO8iM6+ViKSdbgQU5RSOmDrWUzszpgZkj9KBuQqFeTjAxlm2v72QiL6Vfd1r
         EHqBRy+jVEEzMN+QQA/Sz8ob/3x+9fPNTIuagCurMU9ee4cItd3C4f0MjvoDZqu2+DEV
         vaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593951; x=1706198751;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewpSOiW9RlGueTIhRS4yCwW1pNfEZiBqcXxXwqJipKQ=;
        b=YXfmrDtIUZTi+dX52X5VUY6opwc+FKJSAwLa42gv4jStlfgY1H8zJMmf5y9PHauDsC
         1NRHZCpdaC8Yzceem6szxvDOL53De6QnWQK4huJUNrQOAq4mq3+oua8lsqheo7AduOWe
         6VYsZZZbhCFBEh9qWIxLxGvS8lOQu7sEbmtL3fXlJdSnQatMd9qMmfkOcql3CXbB7eSQ
         Wd9hGF+S8sjKZOtRprDykWc5eU1ILWMuzVOyaVc71m7W0//JDW8NrZY2dYQAGwoyASEo
         ifMgXSR6W57XMkm2sCSmbmBzpqKWs7nd1LxnzodOcpj+66VDQgze4MadTCSc/zQdM30+
         yjXw==
X-Gm-Message-State: AOJu0YzOnVP4iIaf7231N4rvWNOn8adAJ5omzfDx3p4BnfbE9DGtDasW
	hUNRsHjz5raJZHiqp7oDxnb8+N0CvYIbUJ7ULXgEs/cKmIZ7XUZc
X-Google-Smtp-Source: AGHT+IFN/cFLtbIF8BO48zR0E3rZZkyjEPk0zcajzYzTSRSpiMx6/yub42dUnDKAWuHm3lulQAPf+g==
X-Received: by 2002:adf:8989:0:b0:337:bc90:2148 with SMTP id x9-20020adf8989000000b00337bc902148mr526067wrx.129.1705593950924;
        Thu, 18 Jan 2024 08:05:50 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d4a89000000b00337d8b76b36sm298914wrq.68.2024.01.18.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:05:50 -0800 (PST)
Message-ID: <6c79868f5e66c4a2c2b8c2bd30422cb167b656b2.camel@gmail.com>
Subject: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko
	 <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>
Date: Thu, 18 Jan 2024 18:05:44 +0200
In-Reply-To: <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
References: 
	<f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
	 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 17:58 +0200, Eduard Zingerman wrote:
[...]
> here is how config for x86 CI is prepared:
>=20
> ./scripts/kconfig/merge_config.sh \
>          ./tools/testing/selftests/bpf/config \
>          ./tools/testing/selftests/bpf/config.vm \
>          ./tools/testing/selftests/bpf/config.x86_64
>=20

(For whatever reason CONFIG_PACKET is defined in .../config.x86_64,
 maybe that should be moved to .../config?)


