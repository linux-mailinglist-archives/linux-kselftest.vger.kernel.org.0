Return-Path: <linux-kselftest+bounces-22363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E229D3F86
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B99F1F221F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A215380A;
	Wed, 20 Nov 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFc3kEao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483C137930;
	Wed, 20 Nov 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118194; cv=none; b=WFXkwV06uRe+ZQmKSIfAH5789EDGiifJ5d/LG2XMwKMp3sR46rKiT3WMseZ/wvDwk9+C3KGf7CQFxqj+GW+78zub7dEhvOSJsFfIOtR2Htyxfy6G2YL/c5K+Q+Fz5rc8PiSIHLY/4CQV1qSC0Aj97rr6FoolbrbJSMSNbfPhdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118194; c=relaxed/simple;
	bh=gHYszuF31pK6zNphWs0LQBhZ1BGw/HxT8NkzzEthVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgTRiqxI6Qoh7ZCa3BkbzDGDJnhs6xVXatxy0sS+/VbGjYCsm90PhoHWN2Kb34AaZISXMv8yfOXnKoXtBSQDfLQKjJvoAoA38AGjdCUgJApXKnWJXxD5rFY0yVIaV6wx+6DiIC3TUDOImTAT8mmMq1gGCL22JDfC+/iGC2wH+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFc3kEao; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21262a191a5so16796865ad.0;
        Wed, 20 Nov 2024 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118192; x=1732722992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faofSo4oKVxuq+H71CBfM+zOMDUns1O6D6WWNWtO2QI=;
        b=lFc3kEaoTZ+U0z3BAzTPcNBXZrzwMQZRa8hzROGw1T4zHyB5AXNJwsrTInEgnyG3jY
         +yWG6ikTchmbrhqLsdesDWzO4mJVg/K5iGKHUSilHFGcqKT0JMMaINKljFnK6vRDQ1DJ
         SYFrdPD4kbPXQRzSOkN+H9X/QL1Ef+2IQAvtNUUGB3NKuRZ7JcNFL2fDc1XCM4Rhh3SS
         SHT7JwXdkh4y6Z+mCgtZWRE7cm9F6/6gIGlPl31bQIGH+KHIPNtgfdRD3xAuiAMqcm3B
         lCC2cVn+EwqHJksIZqNbAwVtbbtVBDT4jrjrozFyL8Ei+zODqzbU5GC8hTkwuyGaKK9o
         yH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118192; x=1732722992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faofSo4oKVxuq+H71CBfM+zOMDUns1O6D6WWNWtO2QI=;
        b=m/IuePSuzjVds0uSrtnRPrzBiRiDikmtVYvOyZGBc1HYOOYesLGy8PRzElf/9vTJmN
         1QuhDG8ru9a+vXVr6V4v6YaDjWs7YptUXe5FYmlBcCigr6P0PabYw5E9zbqakZjC3gQW
         7El8XezkzDgrC7jL7pJayDdPJ1B2n4p051vii03IFPEEhce8hK/ku8bP2XcuZ+T/VUeA
         6bGi7ZeuCZsY+GTUi7p1zwAMZP0R3Bj/IPkEP7fIHKe+R1bNw+9tBXm4jqIVzkPboiSG
         JSGwxQtmT4khq4i05k2u6pgKOHpluOrYKNinRb2bRBxxM4PdtJV6hja+xFMYkls5qLvj
         DuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwF3jfhyXRx5fg2mLE0GtJ3lP9StYejqRFJyjSZxleZumA0U139IR4+TnxX9u7EArIz0LcajFrYntCex04@vger.kernel.org, AJvYcCW3Y4+XVjYOHfqcQv5aEjLQUbGMjVqpPFc/nO8le8IUs5g4peMlyoCpUV4C9w4oDU5tnmZxyz+8Gt63REUsAc2e@vger.kernel.org, AJvYcCWmBRed5bJbymI6L3jbBjvq9mltfhxkr0vdcCShQwWJS9RDC3u4wSTIj2Xqex1XkyUVTFA=@vger.kernel.org, AJvYcCX5VvDLhiCJVtUkCRbrPxqRF8iE/h8nZmALbOrEFw28m95Tbx7r8wpIKTyhLE56cx8Q52x5oUSL@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKyZuEpDUanR9lYv7CKtK0LspN2tOH9SNyTHrsXkr8+Yt8Rrc
	+t4UAI2ZM40N0qkLV4wOVPNnZYwg4Cn35g2RBkZA7yMpniPuwAY=
X-Google-Smtp-Source: AGHT+IGo4oI+Fb87+Czb19lD2BAZoMXT0M6InkIab58s9UkvKgbaXbQ08of0yxblvqBw/za9YhG6Vg==
X-Received: by 2002:a17:902:cf0f:b0:212:b2b:6f03 with SMTP id d9443c01a7336-2126c12c410mr33196935ad.16.1732118192127;
        Wed, 20 Nov 2024 07:56:32 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120b2c54d8sm63940025ad.235.2024.11.20.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:56:31 -0800 (PST)
Date: Wed, 20 Nov 2024 07:56:31 -0800
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
Subject: Re: [PATCH bpf-next v3 13/14] selftests/bpf: migrate bpf flow
 dissectors tests to test_progs
Message-ID: <Zz4Gr4lNt804_dyP@mini-arch>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <20241120-flow_dissector-v3-13-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120-flow_dissector-v3-13-45b46494f937@bootlin.com>

On 11/20, Alexis Lothoré (eBPF Foundation) wrote:
> test_flow_dissector.sh loads flow_dissector program and subprograms,
> creates and configured relevant tunnels and interfaces, and ensure that
> the bpf dissection is actually performed correctly. Similar tests exist
> in test_progs (thanks to flow_dissector.c) and run the same programs,
> but those are only executed with BPF_PROG_RUN: those tests are then
> missing some coverage (eg: coverage for flow keys manipulated when the
> configured flower uses a port range, which has a dedicated test in
> test_flow_dissector.sh)
> 
> Convert test_flow_dissector.sh into test_progs so that the corresponding
> tests are also run in CI.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

