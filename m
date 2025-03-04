Return-Path: <linux-kselftest+bounces-28190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E858A4D762
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95811177291
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6B1FE469;
	Tue,  4 Mar 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HoZUHGFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA301EB5FE
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078846; cv=none; b=dr5sTm+8oifWr1gnxfcxy1+6oY7uh6nxlbRakdf1ZMNP0hSxbqSN/CnB9uS85F6+OjzG/sOKViJbgnNAFZq+VCGQZrYu92g3Kw/pshhgQSDxwVc9Vw2BYk1Ec96vK265+tDDQyRHeBbpyhDS9waqU3cxgzYCglxF0YIVw5VK0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078846; c=relaxed/simple;
	bh=C5ZHUydAfD7qIPC2fugkdbL/7ZQbv9+E48hf7fmVHuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBwYVL8xKmFxzCJhWgyjOn+2/TwqHQpvddhsKfES+HTzjpRI8PZMsr+FAW0YWSB5BmjmZhrnc8GXJT70Trpjp7OPO5xMsQ/gMD9d+F6VURQUuXc2NsDKdgbku659IFBzCI3uL3ce6xbWALO4n5nDdUQO9JvBCcaTTZh+eoBimww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HoZUHGFH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so10541165e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741078842; x=1741683642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UP7DmGMGEllBfFdaot9026+FUs+6/ByI4Mfm7p9ZUY=;
        b=HoZUHGFH3Y3FTWhwkHDQQUy4JseQKHJd+NaXAIQ5OId1VHbF6srGTfUWL4YPG9UU6t
         9OuRn+3XADWpRHOI/g7l9J+52arW586qdZvgBhfCMBlaE0P4Y32HnL9A55y/kA/LygU2
         QLAFLzP+hw15qhUlx+v7gJXMXdycytGcpQy3cMiEwrSVjnlKCur0jKKGoJ/Bmh5RvL72
         wCukzIqEB8iZTsvvm/H0yy1enT8OrcBWc9UGcVK7h+05c3b5r2TmsUSH5H9t6K4yJrHf
         V+rHcKmRSsU7DWv/JJMNRxnl5SRe8seaabn8A3pcz4DXhK6XPoG68ge2jV0iqLSG7fXI
         YyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078842; x=1741683642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UP7DmGMGEllBfFdaot9026+FUs+6/ByI4Mfm7p9ZUY=;
        b=LIBf7YnCGHEwHrz3IkIcdQWX7dheYeaO6JC7Ok5Ce1Wlt+E7n+74dHR9o8uAAB+mEB
         JuY0vD1SKS5UlN7J+1vZYl0MjIpgfKnbzEtbss9qc1tuPhw3trOB5CHtU6KsbIf27sT3
         yiBE3dNRh2WULVFt/P20v1/3d1cK0kFnUl/8E7u4E/OWvvP0/7LqxMuf7p4ZDGyGolY6
         lHS7HWhhOkww4DsIUY/D+UFGCnhLvKtEOwSMcW1Vjxrl5DbSxK9h/SbtqIKAnEnVHKPY
         Ru3xt6GttF6RQR4n9zc6DGOvnCy4LgjW4mFmPMxTjo4UkOhlI567PYP8nYvwMNT5uB2V
         Fe/g==
X-Forwarded-Encrypted: i=1; AJvYcCXy6u0m7S9JdOtkFKM7sAFss+wa1vEcfH+d5jOxbM6WKZjXLn2DO+L9tcPBOza/r1PYvBj6E/4zCQVUMr7CnZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkd1oRQahiVUQ/+UtDMnW+B9rvmPOm+vRIKDZGmIJapFfYi7M2
	rs7hzzJbyvwW9IMLusdOiIMXP/RSOInqArqpI6mIzEM7P5zqcgxwAcNPNYHmqAg=
X-Gm-Gg: ASbGnctgsBYEqUidyMj5OHfwJii29wnJYKmFhmXKkTdsDrdyszJruPgPmw/qudYMK1t
	x42FNaNI61hYYVHvVJ+5syH4HDea2hvliB8RRvff3JG27b+umWM50jZQkCxH5dgmjV0Y1Xj61e9
	CyFYoYvMdlYJGdj3YZ9XOqBqA4p7UGrJxQyfK4W6rZnJlpZIDduKz9pvDTVXWU2eLN1/1HBWbvT
	ZMkJWV7wUYvA4/H0MIEsB9zKS7PpZs3ICP9utAKZRofpuyYTPe97+nF5DqtIGSinnDU8p/XejKn
	V7odLqIb1IChLYdU9HbXiIIO6WAA+19N
X-Google-Smtp-Source: AGHT+IE98Wtw/qck2RNdbUy35iBZdcuCmo9BHlXLPhcqJEgVkq5LxR8GTapjzExbGuStv6PALsyUfQ==
X-Received: by 2002:a05:600c:3b23:b0:439:98b0:f8ce with SMTP id 5b1f17b1804b1-43ba66e60f5mr143195855e9.7.1741078842210;
        Tue, 04 Mar 2025 01:00:42 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2edf84sm75715855e9.40.2025.03.04.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:00:41 -0800 (PST)
Date: Tue, 4 Mar 2025 10:00:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] KVM: riscv: selftests: Allow number of interrupts
 to be configurable
Message-ID: <20250304-bb96798e9a1fd292430df3e8@orel>
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
 <20250303-kvm_pmu_improve-v2-4-41d177e45929@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-kvm_pmu_improve-v2-4-41d177e45929@rivosinc.com>

On Mon, Mar 03, 2025 at 02:53:09PM -0800, Atish Patra wrote:
> It is helpful to vary the number of the LCOFI interrupts generated
> by the overflow test. Allow additional argument for overflow test
> to accommodate that. It can be easily cross-validated with
> /proc/interrupts output in the host.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 38 +++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 7 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

