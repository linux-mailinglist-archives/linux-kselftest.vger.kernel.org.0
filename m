Return-Path: <linux-kselftest+bounces-43394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F16BEAF0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF367C5203
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEB29BD85;
	Fri, 17 Oct 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JJyDyB10"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16512836AF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718018; cv=none; b=ONiagi5VYm4sI7LvJmq5XVORHFebMsjE1KmSWRNb14w6WO9Sib9x02xYTpSZFfB06nEZbgcTRGqG7MGqSmd3DtNKNilPce/9+m5lffhrWlT4h+399o2PM/RM3PJTdDIGi7pKoYrB+6XYL/y5KwS1R8+QKWjERs0W5I2jmcd/ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718018; c=relaxed/simple;
	bh=51ie/4+FDOx0L86siBsGLHph63M5h6PAozXIjd28edY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwJ6kRaZNFEYk8ValHo0qIAmddGoe+GgNM+IZ/XpgiLKSZ/TeBIIXwKiwjN5ASy22EKQ9jx/+2j2V0onB3CTc+944HG/zEFooEIBo6orKVeZ2mpuRGNCgsSkjHGMkVRIp2r1/7njl0z0NvRfbXzbgwPKVWacHxM5C9FgDKxWwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JJyDyB10; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e7ff97d9fso50729239f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760718016; x=1761322816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLnYMiGE1i6wdt2kWbvCEK+VTfi2UEFuvCxtEUGWUPM=;
        b=JJyDyB10ySjPrQmCjTDGOeg956v64V+nGtHBrOPGIvn5+Cp9S/eEEYcDpScMQXGhKj
         XGfoskf+cVR7t8S1CIxTHljDY7XEGhD6q51D8vLvmh30dv2Aoviu7LsOMvOYU20bYrAB
         82ui9RgONM2ckrgOBPnTt6LB2pJDGSrTDzQioKTr9eQRH8vIQ5Q7UAgbe4OIiASLx81j
         15bgG1VDel1h3wz4cQyLAHdWXajlpHl7V+d4weKWqYEa8jPWBZ4BlybctadAemFr2Lbg
         4d5O2A485feifbJ7W/g17ET6g65W44oJThMHD9g9P9i5BIZIhN+/QoFmv5dEu5QxJIzM
         FygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718016; x=1761322816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLnYMiGE1i6wdt2kWbvCEK+VTfi2UEFuvCxtEUGWUPM=;
        b=UBW7FfXfvg7xu3rbkU/2Ww96nFlj15s2vfqh/dyOP6R8tm0aga8ebnJOUc9vzD8QO4
         5s+zOGXkJdLK+M3bOdSvzz1epbTtdK9yJM75x/inAQOqhPcWcOluFQScm908/t83Wuan
         meKoGFOmV6251k9WUReGBwh5F0iVDAxsh9Mje3Yi1SxiQEt7AZagHWm76MoGJx4yYaZi
         T+8UuTzKgcTItSrSnbtxUiGZUKy/JavgxYYE8TXT4fjg1JSJ+iHkaSi9OtS789FmjqAb
         1Beap1tfTininwauBOCXAi35aWIxtq5FNL5xZOmhHY3GxgEglT6cXSj0nhy8fzajuv46
         e53Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvEkloWjz0ICIs/5lfj+24Sa2oifzvS6cPYv0FgLhZydNuqy40I9xU6d+ygCQPii7SzpFQ7ZYZXx3hEt3B3K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcwkenlWDAa3AmPIrh/v3g2Qsn54ZUj8SZJ/fNfP5zYgJijrs
	OuvSi6V+KIcFJP91fcG9rgM4TGRoFmJhH5x97wUdP8PDV63OCMgt+muPr+DGi+F+zpI=
X-Gm-Gg: ASbGnctTCfRRphwqgJgD2CjHuLAajImQ6k3xP+gEQ6aKLKyF3oek/t/yXizvK3cK4ei
	9dpfuxjxzGLuxDDBVaVVFP/kW1wIE9o1dipKOUdJ15A4uXVJDAfvzN+vvZuCPmJoMNUXJKF1+1n
	L6sxv6/O9XsBK1C+AVRGCw+KuJpRoloU1o3J69BtLNFyZUA8U2JGVyzUj55oxAW5KZkyjxuwQxd
	zD5fY1DDEfWlZcIJxHdFxcW6mumQdusETBjlW1YJCYdFDbgwRoDB+2y35r1M6Xt5rOyhlyPp0WX
	MAo3L5MFuBK0FPx6z2UoQKWhprlUTFLxMwEK+j6YpBGyOpFYr01YnyYXL9BW+oDgm5tX5e2tKor
	BobY/aEzUSqXnyh8Mdg38JoaRxLjXzh4Tx1OnvD0I0AfW/q1I3V/lEof25T34rxRtIIGgbsFYNb
	QfzJDdpYtuPdbL
X-Google-Smtp-Source: AGHT+IGx0p/Murx0/nwCjsggRoQIsfWi9xXyoIzQDYLWIYmSzYKlABJ6zEfQQ5rWYKVGG7cg4jaAGA==
X-Received: by 2002:a05:6e02:1a66:b0:425:951f:52fa with SMTP id e9e14a558f8ab-430c5275304mr65365645ab.14.1760718015987;
        Fri, 17 Oct 2025 09:20:15 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fecfcsm22608173.13.2025.10.17.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:20:15 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:20:14 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] RISC-V: KVM: Add SBI MPXY extension support for Guest
Message-ID: <20251017-cfdb6c77b74b87b784a3bd35@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-4-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:24PM +0530, Anup Patel wrote:
> The SBI MPXY extension is a platform-level functionality so KVM only
> needs to forward SBI MPXY calls to KVM user-space.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
>  arch/riscv/include/uapi/asm/kvm.h     | 1 +
>  arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
>  arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
>  4 files changed, 13 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

