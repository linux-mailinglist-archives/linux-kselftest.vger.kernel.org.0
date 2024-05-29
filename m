Return-Path: <linux-kselftest+bounces-10874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2898D4131
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDC11C2195E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9EE1C9ED5;
	Wed, 29 May 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QKNczN99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E61C9EC4
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020795; cv=none; b=nMrDYZbcm88bk0jQ6d5mlWYdyskQxVFbCk5PgRCn5lHvKH9atfp+gPyGaJv4JSwla3XeiMYeJazFDWIZP1liS6o6rKGDaSpX0B4g0nTwI5a32X93kWsp5Sy1bjcc/Ntmhk2uTZJRszrW0mWhJ1KdKCjlt61XpQdHoVfyh0mccqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020795; c=relaxed/simple;
	bh=Qpm21gYNPzC5coWzUo4QZV+kF+pJIchx2KZIx+YUsBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBZbUkbtSdmV3Mqy9+DnqaAHLzet+cDHGPfte5GcsNTtT1/fx8aUyO+yQ9Oq4tljMhrTM8DoMJfMlvXE7my6CDdgd0Z9b4i6wz7Zefksx5w3rh03MJ9cnolCgzCWhB+uKO66z2VgQk9ASVlwfQ9su8IewODqDRJ1aqX/mK4MT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QKNczN99; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-681ad26f277so202705a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717020793; x=1717625593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0IlII5UPz7okOGVtp4oFhfmfzPg6aAU73p7l7C1qc+k=;
        b=QKNczN99ChlIoY7dFfMTgiQq3y95ZGgCceefk7nUgKe3325kh/prJBaYNA24dKvf00
         +F3SMZOGdq2nfXraMvqs2M4HcjVmLwsuqnaPmDeEUsqEggM7Mc9GNjeu6FqIXXCB3eKC
         q+h4OmPNPXmmcjwlH6dfKUolBmn6f7sE4TATR/ZUNAGB9Xez0+qLaLO7Xiia7KymrGga
         jSO7ZLAAWHsniLm63V1ngqKLL8cv1toyYsExScEkFyEDvkLgIiX3MrjrT2Tsa+HX8Qdj
         qDgt2ZOSvs3CGEUGCRXyEahYrCOMAQvbbaoIX8iLvC18EpqUBVCB0Y7BbSIBbho7e3fa
         0hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020793; x=1717625593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IlII5UPz7okOGVtp4oFhfmfzPg6aAU73p7l7C1qc+k=;
        b=EuYfg7Zn52Pspe4mqfdsax09UIgFjcBpCpGm93bKC5dKkO/wBUvxvTvLZs9T7D96fc
         KqvC7GENMYKvVBNx8sQseLg9j4SmBE50YrHbodMzewCPON//yq/kZID31zsMxTmlLgq2
         jM/9COZ4CA0yplRxDdXqxGtS1+ltrpW6Ik7I/M8S6oCPAYVYW0yZravvIu4mwta/AkHY
         /bwmo6IyvJguJzStPtwlsx8FC0wz3I0e/Z78ieIqstNmQGvbYv8un9yl6iuBqOo+2eYe
         Sov2QbQCeI+nK8PvFaDM5Ag0gNKlLkv4+iMgxeMxMy+dEAXnXtBT6m/zv0epLcnwdV8k
         rQVw==
X-Forwarded-Encrypted: i=1; AJvYcCXnP/uD6LfrJq57m8+LAGb2wdpABGgvVwiIZ1p2G1MIG9jNb2+GCWCi+BzfryB940tCj43dlKqMsw1Ah5N6Ny4g0WyGoRWhsQH7HDCx3yeu
X-Gm-Message-State: AOJu0YwizdGAwz5DvwXRBGcK+FK/prnD+c66n0DvMmXzz5RJTsLhB+hm
	o6+intj21rhMCoqZavyG9QF5nJLZN7CfB9ZpABJCLG3hrN8srGzY2CBRa5ViUwI=
X-Google-Smtp-Source: AGHT+IGZO+QhLAfwlgYNEFfJDCtn8LQjOZE5KcgbzkziiPV98AS34GxnJcpziGZFsgu3JA+ZTJhYwA==
X-Received: by 2002:a17:90a:ad6:b0:2bf:dcba:a3c1 with SMTP id 98e67ed59e1d1-2c1abc3e316mr512737a91.34.1717020793113;
        Wed, 29 May 2024 15:13:13 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:32f9:8d5b:110a:1952])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7772cebsm287763a91.17.2024.05.29.15.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:13:12 -0700 (PDT)
Date: Wed, 29 May 2024 15:13:10 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 06/16] dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb
 ISA extension description
Message-ID: <ZleodmaYG7qsvNmu@ghost>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-7-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517145302.971019-7-cleger@rivosinc.com>

On Fri, May 17, 2024 at 04:52:46PM +0200, Clément Léger wrote:
> Add description for Zca, Zcf, Zcd and Zcb extensions which are part the
> Zc* standard extensions for code size reduction. Additional validation
> rules are added since Zcb depends on Zca, Zcf, depends on Zca and F, Zcd
> depends on Zca and D and finally, Zcf can not be present on rv64.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index b9100addeb90..39084c58d4e4 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -220,6 +220,38 @@ properties:
>              instructions as ratified at commit 6d33919 ("Merge pull request #158
>              from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>  
> +        - const: zca
> +          description: |
> +            The Zca extension part of Zc* standard extensions for code size
> +            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
> +            RV64 as it contains no instructions") of riscv-code-size-reduction,
> +            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
> +            of zc.adoc to src tree.").
> +
> +        - const: zcb
> +          description: |
> +            The Zcb extension part of Zc* standard extensions for code size
> +            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
> +            RV64 as it contains no instructions") of riscv-code-size-reduction,
> +            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
> +            of zc.adoc to src tree.").
> +
> +        - const: zcd
> +          description: |
> +            The Zcd extension part of Zc* standard extensions for code size
> +            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
> +            RV64 as it contains no instructions") of riscv-code-size-reduction,
> +            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
> +            of zc.adoc to src tree.").
> +
> +        - const: zcf
> +          description: |
> +            The Zcf extension part of Zc* standard extensions for code size
> +            reduction, as ratified in commit 8be3419c1c0 ("Zcf doesn't exist on
> +            RV64 as it contains no instructions") of riscv-code-size-reduction,
> +            merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
> +            of zc.adoc to src tree.").
> +
>          - const: zfa
>            description:
>              The standard Zfa extension for additional floating point
> @@ -499,5 +531,51 @@ properties:
>              The T-HEAD specific 0.7.1 vector implementation as written in
>              https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
>  
> +    allOf:
> +      # Zcb depends on Zca
> +      - if:
> +          contains:
> +            const: zcb
> +        then:
> +          contains:
> +            const: zca
> +      # Zcd depends on Zca and D
> +      - if:
> +          contains:
> +            const: zcd
> +        then:
> +          allOf:
> +            - contains:
> +                const: zca
> +            - contains:
> +                const: d
> +      # Zcf depends on Zca and F
> +      - if:
> +          contains:
> +            const: zcf
> +        then:
> +          allOf:
> +            - contains:
> +                const: zca
> +            - contains:
> +                const: f
> +
> +allOf:
> +  # Zcf extension does not exist on rv64
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zcf
> +        riscv,isa-base:
> +          contains:
> +            const: rv64i
> +    then:
> +      properties:
> +        riscv,isa-extensions:
> +          not:
> +            contains:
> +              const: zcf
> +
>  additionalProperties: true
>  ...
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


