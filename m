Return-Path: <linux-kselftest+bounces-2996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0940F82DC6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE82B216C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383F1774A;
	Mon, 15 Jan 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PGDOR7ja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545717743
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso10745025a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705333036; x=1705937836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtVFGxo6W2R65fH9PJDIGxutILrI7qYWvuUFM+KEdWM=;
        b=PGDOR7jaTYqs+kPtlYCvGWEPUe79DQfi+8tlmNZedeLOEfOZ4175VIQ8ByGNRK0Z9V
         BVhQoUrZzdM6FCHqL853N6sNTOZGNVPS/ZX8Hzv96KChCdKC2UT9TzweYM3nUMxrR7NP
         9yEIbSpo7mwxYK0+xmAgHQ3p8EF7KSUOvS6eKg3WBw+ofSt2X1iTeJFeiRD7i+wHbcjM
         QwKZ3U3zhY7rQbRcYxwe186G6Tye1P+JFfMzmCm+k9jv9QUHbQ/MvNq/3bGB6VajjsJT
         sOD4TX2lhGtNXaMeOx0XHcG734iwYkGQpzS6WXuELkCRbF2SzbFG8xhZ737b1/EooJaL
         m4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333036; x=1705937836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtVFGxo6W2R65fH9PJDIGxutILrI7qYWvuUFM+KEdWM=;
        b=IMp7e2PfyMe0hFSn3Lb4BQFTIOGbc4BtFcg0DlqQcah45X096nfHvHKvSdWAtpCZql
         PzG5z1IdbWhpSfgVdpbpvgdaMV5kdjbcI6ZP0O7M26r9TrKBFYQu8FqDRCN1S8skAsaz
         Ve886WlqT3huH7z14zKl3/DR8Hdzif0sfnUnMKnpLEaPWviUM3IWM6D9fs5tVOsEesI1
         2361r3lqDufskrECU7ukrsykxvUJXQS/V/lh3MToIPe0/EGexmWSiXC+Hh2eZH3lrkgd
         m7gZxFJ8w3nrn5uHdbKer7EuKqv9atyEIP8xLvJJBO82vxckh+FNEnL2nzwlFhi+xsuD
         DINA==
X-Gm-Message-State: AOJu0Yw9iHaJEXvH92g6C2SmImUMfvYKgzYCVsFqQqtemJSD8jtRbQpQ
	PnrsKOVeR5bJmO9jUDRBElVQDs7Zu3h2eA==
X-Google-Smtp-Source: AGHT+IEI08RzPRo2T/KkNS6TnGCQRQYJsQKdpADX1cVkaNpJvEz5jdj0uYe02wZKAjUq+lUaF8fA8w==
X-Received: by 2002:a17:906:6d18:b0:a2e:3a19:f20e with SMTP id m24-20020a1709066d1800b00a2e3a19f20emr179739ejr.64.1705333035883;
        Mon, 15 Jan 2024 07:37:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a2d60b5a502sm1496635ejc.224.2024.01.15.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:37:15 -0800 (PST)
Date: Mon, 15 Jan 2024 16:37:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/15] KVM: riscv: selftests: Add scaler crypto
 extensions to get-reg-list test
Message-ID: <20240115-c690768430c76a2e595a7c86@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-6-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:47PM +0530, Anup Patel wrote:
> The KVM RISC-V allows scaler crypto extensions for Guest/VM so let us
> add these extensions to get-reg-list test. This includes extensions
> Zbkb, Zbkc, Zbkx, Zknd, Zkne, Zknh, Zkr, Zksed, Zksh, and Zkt.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

