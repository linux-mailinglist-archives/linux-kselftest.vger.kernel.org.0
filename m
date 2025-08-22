Return-Path: <linux-kselftest+bounces-39768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A838B32514
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275E7620D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7828299AA9;
	Fri, 22 Aug 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4ltF1m+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23F1E5705;
	Fri, 22 Aug 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902158; cv=none; b=SNKvk6FrNheK88RJPqbI3fIxlOh2GyTN4vVpUSI55ue7PwNHtx0mJOpCigfHnzn4PLJqoz1/Sh/2a4VjTyLOsM4LzFeVZ/nQxFkomHeBlKsw9HOla2LWQik9waV6QoO0rvpNiYIgd8wyOEjiDDFVzCjsNQsqkws6X8HLslPkCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902158; c=relaxed/simple;
	bh=Lhwv9UQUrS2xvVCkZM2LZ1wXZlHrl5i/oZNWX1nu4AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwvgJkFzpHfeFXpCgXzH/RAXEfwx6S06vlt0lrMzveUT2y5UVfEKyrMhrZktFujvrxawEn8xvgxmjwiNOmkv51pjqXqZzy6kUPbwb7SEB+YEazg1TSdXHJAIyTCU7MxPTGB+QVzDfzTUmC9eSkYTxDg5VuwS52O3Ysy4ehVZM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4ltF1m+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso1906366b3a.3;
        Fri, 22 Aug 2025 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755902156; x=1756506956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FwDTbQ/G9GOnQP/jL8VoYGNnb8b98LqDD6ErxzxZ3A=;
        b=W4ltF1m+sbZLaUoCKO9JjIiUIqKuwfDwKijRR2u2N1DM/pHWPwUFFh0PiUWWzKYkrB
         ktNq5zID08UUQWXv06yknV3BprkyWK/CBiUPDXYWLTQ0oDK9zbunk/tuUJGoqwSr/Rpj
         9eO8c0nEoDZlXTvac45QjiKWTC9gpN26mWemUhA8Aeep6V2lExb0fdJnh96g71lDlBEa
         f9xLiT248uzUbaItrExn+z/s1dQsW62DM4Eyp92FauTqyaBYvdnCX2Ba6SBA5vV2ZxXJ
         ZJDRuVkJkaBhO4kitOi/CZdAHCcu+uGMltLZZrKfkK2UhaNNpqgEtrw4pk07UKlLrg07
         mz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755902156; x=1756506956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FwDTbQ/G9GOnQP/jL8VoYGNnb8b98LqDD6ErxzxZ3A=;
        b=t3sNa6UTVrX6dOB+/vk0I1ZcoRRXsogOyNSGhOyptzrlO35rkZRvxv5+5MN++ig8vl
         9t2BS3TyXGMWHNy0ifw4L2EZ87+ojCizMbGP2VZoh5VZaTj5Y7M9F9KhMzMkHQlJUOJ9
         n0YX+C7/i6aAtWNXj6Dl0CJ+OdCEVmvmLcnrjQ1FI07nvkJzkAkEJCuDenAVBu/6a4WK
         1nv6qQ7y7C6qEC0ouX1b7GWJicLquozzWzK7gB82py0SKCjonrKR3C2bjgaVCM2DSxIN
         4zz5hdY8uJM/uWDfNgl76i2BWiGH/8ak0FlppShHX4g2fnoKp9Tl5M+xRbI/Jg32wBmX
         axCw==
X-Forwarded-Encrypted: i=1; AJvYcCWLJrdxjDbHpPq5scKCp1CoND+PhSCjfclAtKxYgAk4unr1eqC2jdtH+nXEaYkHZoy69PL19c15pRoGnK8j@vger.kernel.org, AJvYcCWfpHMNIdGRQ/0lhh/O/Umv6ne4M19isb/0jhcwUZntryU9OjlKZOPc2k+e5pVsMeRSqV2P@vger.kernel.org, AJvYcCWtUJo/wEHkHBQy8kmWQY+6ZMWi0i0eYRhGLvnmy7wIv/cFKAabay0qepefHcOjP4T230OQ52ac8rC0@vger.kernel.org, AJvYcCX0WPQEx/X+rGPqiN9FYbzXRlTcHyl+3W7ZiT+LXpRMBEm0KI95pjv9IlYCDfzFj/UzK7fV6f4bvqCs@vger.kernel.org, AJvYcCXxPXVI7v/S+LLqoW1KQpI3qSdeSyhN1IQ+nf3CrADvMRasR5lrOt7ri90o9GolHTBds/eMhcNhBpnLb5jERFZJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnZ5w6apazYOAwCT1o3ich9Yy8GZr60GrIUVTUfq4JYuQG+Ms
	Aytq0j7qjRmL1257gKZzzK2ZLVR0R1S25eR/5ywLVULfjdFUq+UCLjSG
X-Gm-Gg: ASbGncskW30UaHVDRLT3Qve0c/crj91ZSRivsAstgNAoAedroGXns4mtir3I0QyDg/z
	JCjQr4GRmn84cwKTDINgBS3520/2c9m+1GTA83rXKLWPQmo+q1R1WgpgYg4JlTieeS5umbAkGR2
	VzJny8JbfiD0XCTi9KwwYvPmonxzfclnUnQ2OHhEbJhwRZqOTtxgDNQXcSajf7b9u8472tGYTkS
	Z1dt6IHB3tJggHVIQj56SKezLGjvOxDI6FieGuUfS01zDMuRG0jjpQhw6cXupntWca8I1dqBBCB
	KbXVYk5xTM5niqzwJFWfMGJTcnE+CDpiz68QxHkZ+RsUg9+Be8X11KMZqabnrkjbmYd7Ei1qXmt
	bwhqZ1jwqJWaSiWXL+bW/lw==
X-Google-Smtp-Source: AGHT+IEYCh8C0L6ZZn0L/gbp+7wJ7PcWlxjsVE+Dj4tzEhoWhx2t2CE2bxPom3RqYKmnOJkBIwjJZA==
X-Received: by 2002:a05:6a21:32a8:b0:240:3c3:7ffa with SMTP id adf61e73a8af0-24340dc8405mr7563526637.43.1755902156183;
        Fri, 22 Aug 2025 15:35:56 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254aa4f9e6sm802727a91.16.2025.08.22.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 15:35:55 -0700 (PDT)
Date: Sat, 23 Aug 2025 06:34:56 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, anup@brainfault.org, 
	pbonzini@redhat.com, shuah@kernel.org, cyan.yang@sifive.com, cleger@rivosinc.com, 
	charlie@rivosinc.com, cuiyunhui@bytedance.com, samuel.holland@sifive.com, 
	namcao@linutronix.de, jesse@rivosinc.com, inochiama@gmail.com, 
	yongxuan.wang@sifive.com, ajones@ventanamicro.com, parri.andrea@gmail.com, 
	mikisabate@gmail.com, yikming2222@gmail.com, thomas.weissschuh@linutronix.de
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd
 extension descriptions
Message-ID: <znik7dcyeipf57xerlm5gwjszcaaeujoukr7g4a7wt7lsfu366@skany6k7agt4>
References: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>

On Thu, Aug 21, 2025 at 10:01:27PM +0800, Pincheng Wang wrote:
> Add descriptions for the Zilsd (Load/Store pair instructions) and
> Zclsd (Compressed Load/Store pair instructions) ISA extensions
> which were ratified in commit f88abf1 ("Integrating load/store
> pair for RV32 with the main manual") of the riscv-isa-manual.
> 
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index ede6a58ccf53..d72ffe8f6fa7 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -366,6 +366,20 @@ properties:
>              guarantee on LR/SC sequences, as ratified in commit b1d806605f87
>              ("Updated to ratified state.") of the riscv profiles specification.
>  
> +        - const: zilsd
> +          description:
> +            The standard Zilsd extension which provides support for aligned
> +            register-pair load and store operations in 32-bit instruction
> +            encodings, as ratified in commit f88abf1 ("Integrating
> +            load/store pair for RV32 with the main manual") of riscv-isa-manual.
> +
> +        - const: zclsd
> +          description:
> +            The Zclsd extension implements the compressed (16-bit) version of the
> +            Load/Store Pair for RV32. As with Zilsd, this extension was ratified
> +            in commit f88abf1 ("Integrating load/store pair for RV32 with the
> +            main manual") of riscv-isa-manual.
> +
>          - const: zk
>            description:
>              The standard Zk Standard Scalar cryptography extension as ratified
> @@ -847,6 +861,16 @@ properties:
>              anyOf:
>                - const: v
>                - const: zve32x

> +      # Zclsd depends on Zilsd and Zca
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zclsd
> +        then:
> +          contains:
> +            anyOf:
> +              - const: zilsd
> +              - const: zca
>  

Should be allOf? I see the comment says "Zclsd" requires both "Zilsd"
and "Zca".

Regards,
Inochi


