Return-Path: <linux-kselftest+bounces-541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533247F7024
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E824EB20F3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FED15AD5;
	Fri, 24 Nov 2023 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iCbh6pTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A0D71
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 01:40:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-409299277bbso11567615e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700818840; x=1701423640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liKWi3k1bQmGEMyLltDAEJD618fY1ygP7q9s9GKBNQY=;
        b=iCbh6pTSrlU3axKSDVlAEbvJ8FkJrYAlkp7tLPy6XcDdc2tocoULEnP8JKrWRUWL8s
         8Qmq1stTFpQBnTpqByFwVoZ5cFaug1ugwtX8lRe6QzH+hj6nLD1bCO/YxV+581INpfGx
         L6k4BedylFdg+ry+nqhJtkkfyrs69+IOUeT8j5Yhq9E9WiNCq5nMZOqBi2zCfPE/bZpX
         0WnNvPB9fuIPv6WQjrtNo/AyQPGEnwYkn9nU+GsBzWtci2Ip8S1GIy4meYFVx8L31USE
         btemkWbMp7HfTht8JzINJgLzLNK6qmJCFRnRJDleBMvX59NtXZyL8FAzvdO0LtW3ji2n
         1R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818840; x=1701423640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liKWi3k1bQmGEMyLltDAEJD618fY1ygP7q9s9GKBNQY=;
        b=wRUvLROF4w0rjbYTTKsCG1Bh/njbvrHz0q6My0fCWts27cEH1ElLEb+jHM0hud9EBY
         8oNXqMGwK0AQOOltGeI05xvsN2Up+ndD4rNr9HzqOY2n3PJjr0GeUX4EJH9fIepvwbD1
         JHylnOjuZkgdZvbKQxW4UG+HppPeTSBRH3IAut2b1at5ZODlupr0Vo/++cXq7yXO3nJk
         EiRe/nQPO4MrNRlr/LBuBvaxaY97TH1ID6h0UKwDlhzDwSoV5bL5yfqhHqo3ePxAYTDZ
         RHZt9qnOEaF54CEX0vuZpT9uFCm7wVH7B/An3bosKESzFdTj6ceOC1ZLu23Sy9jK3ohY
         cI1A==
X-Gm-Message-State: AOJu0Yx02BKwzMMQwcpmHr1wrnnD54PACIaIZlS2o09KWsr2Fu2g24tV
	2ntOuSdoiwa3tSiCuhRle8D4LQ==
X-Google-Smtp-Source: AGHT+IF9VLUBW6WyHhdlX2rn3vRUYeHRnBcJF0nS6mbPXvTDrFDn41SBn1hGDsyIKy9IjON6i7vOzg==
X-Received: by 2002:a05:600c:a0b:b0:408:3cdf:32c with SMTP id z11-20020a05600c0a0b00b004083cdf032cmr2103866wmp.41.1700818840312;
        Fri, 24 Nov 2023 01:40:40 -0800 (PST)
Received: from localhost (cst-prg-91-180.cust.vodafone.cz. [46.135.91.180])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040b35195e54sm4550012wmo.5.2023.11.24.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:40:39 -0800 (PST)
Date: Fri, 24 Nov 2023 10:40:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Christoph Muellner <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Evan Green <evan@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
Message-ID: <20231124-3934c1b3c4b6dc3f076b0f9a@orel>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>

On Thu, Nov 23, 2023 at 07:58:16PM +0100, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> When building the RISC-V selftests with a riscv32 compiler I ran into
> a couple of compiler warnings. While riscv32 support for these tests is
> questionable, the fixes are so trivial that it is probably best to simply
> apply them.
> 
> Note that the missing-include patch and some format string warnings
> are also relevant for riscv64.

I also posted [1] a couple days ago for the format warnings, but, as this
series also includes rv32 fixes, then we can drop [1] in favor of this.

[1] https://lore.kernel.org/all/20231122171821.130854-2-ajones@ventanamicro.com/

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

