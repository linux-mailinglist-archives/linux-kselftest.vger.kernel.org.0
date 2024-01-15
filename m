Return-Path: <linux-kselftest+bounces-3006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F082DCD1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1891283463
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D1179A4;
	Mon, 15 Jan 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hOPZf1By"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815B18C16
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a271a28aeb4so966487766b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705334219; x=1705939019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX/n9ayE2TXqBTrzpSAo/ZCKYm1wOZhICLqQ9+eiCg0=;
        b=hOPZf1ByoXEn4UL5+2CMXcyMRVa4DizfPpZarj9bX0fw3uSIybSnNK9hloqld5zdRe
         epscjgVmSrF4TK5PFxb8t6Lcv84z/veh27JGULqNVmsKwRNYkpBvClS+3s0aQUV4oY5x
         Y2/hEg3CMe8Mj4G0J+HBucS7RdOLmrROpmvCtVFV7v3OSSNwVQ6PlUZmW+dlmZurJsLL
         56iTnVfQJ8iNNjq9Xu+rYlmR2kPRgyDdh4VUKxzJ50HNMmHOKvRkf5lfaQGsCsZglY1U
         5WZBRZjq6ZpBNC1hnCfH5eDzN61z3je/S3TMOO0mIcW702lCV0wb6mxWwADS9FBJHDAP
         vUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334219; x=1705939019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX/n9ayE2TXqBTrzpSAo/ZCKYm1wOZhICLqQ9+eiCg0=;
        b=rbCPkKTMVPLJEub3GaYF/bR03nx4r2WeQt8Hd6NR660WPVT4FeKlVnEYJvMS3Bf1HS
         HPK2iIGR2nIK/b6whqrGtqoM7R9e7atF56LQfIUR4y+CIcLxk9/NnAnaNUZwh8q0C0j1
         lL3+15KfMaDvcl9OagnUf7tagfZrTHq/mWD7pwxFYJ9UEzjjERhMdyvWr+Gzou1m2vIO
         q0AKT90QvostdMOtYEnmIDh4igqxgN8/qyRZzn3YlA3rJlXZX26QbU3+h4SD/aKeu4ox
         Ry7wiOzRhRLMiRM6X3thugkoUy5GXwcDZqrBWuTcn/LUiWMjx4nFgOfSP2vJ4GYYxvdg
         Hrzw==
X-Gm-Message-State: AOJu0Yw0lpAKsd8hQzAEa5VRu8jUuD4lEt1hIJ9pnh6VT35hz96Z96XG
	JYdX69NYXN4tAG2Lt06dCoP1lFuVIIQkNQ==
X-Google-Smtp-Source: AGHT+IGdCRPcSDRJJcIKtgclsrVYIJsy6Yo/XSgDHXRpg8VrxKkmosHcfX0XNK+DXUF44lI/zci4SQ==
X-Received: by 2002:a17:906:d116:b0:a2d:bc64:52f6 with SMTP id b22-20020a170906d11600b00a2dbc6452f6mr1002925ejz.37.1705334219207;
        Mon, 15 Jan 2024 07:56:59 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00a298adde5a1sm5395663ejz.189.2024.01.15.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:56:58 -0800 (PST)
Date: Mon, 15 Jan 2024 16:56:58 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 15/15] KVM: riscv: selftests: Add Zfa extension to
 get-reg-list test
Message-ID: <20240115-31d643f21351f2fc9cf833da@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-16-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-16-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:57PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Zfa extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

