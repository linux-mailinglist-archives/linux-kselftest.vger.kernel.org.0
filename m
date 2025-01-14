Return-Path: <linux-kselftest+bounces-24465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8FA10CF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C3188ABC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AE1607B4;
	Tue, 14 Jan 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr3H9tR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFF1E529;
	Tue, 14 Jan 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874258; cv=none; b=OZMT8ijDBGlyFBIPa16ZeX3GS3zqQvgkG72wpB7WOoQQS4jGs4HZ5ni6Kd8qA/zJYgGNzHbe78fAvF7XmSchuVtx4l8nQ8VEhKvew4WNc1XDsY59M/NX9gcmj6/HzIXyZKRfRjxQXj83d0Bf7eLJ/0dFsgqw6ucFi077ef5HKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874258; c=relaxed/simple;
	bh=w5d2cePmB+WlFyesIydD3igfl2qovfA7IHPvDdTNOD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tORUEGqNiXroJTaf3aEVIEBBUi+E0pbqScXG1YcqwIke0fTJ6+ul2iMci4JAMAdbZCspIP1LH+0f807wZ1uvxKx210rTtaKtTMKSpFtHvRo8Bqy8hQzDdGYJZFZMc85ZGbdT9bDWEofj2XZjeE6WUw2nyhZW0ESRnv/NZjv6fAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr3H9tR7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385dece873cso2851111f8f.0;
        Tue, 14 Jan 2025 09:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736874255; x=1737479055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyPFycRjvp5c6AtQYiXYIATVbEpsK0e4npb0nthvins=;
        b=gr3H9tR7iJEGd8MeLpMP0HQkLl0j/v1rzU4VukjXO/G19Z3pV4QO71XDhQmkM7fmTN
         9wwHU++jCOYCjGvFDxvQww88+kDziCV/wI3thF/nEOT8yRF3f4t60s3afwejFpErSSMO
         8p1OdPKYSw/lRubWpuAGg7OaUizqh1hmGWm9GHNTpB9r3/+/xQhzha8CtEPU/OCDtz/R
         qzUl4SG4KDUHP3YYrTQ/YHrndCcf0u2GK+3jGbabwvD3bGa/S8MPw0sMmEH6B11qiXPe
         vgVqW+/qe6BjFjPalS2X6+M0YTUl4OxtlL+tL/KRxnglEjYjtTxMo/ERVmU5g08KTIZr
         BQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874255; x=1737479055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyPFycRjvp5c6AtQYiXYIATVbEpsK0e4npb0nthvins=;
        b=hihoSNiS+ckrMCXVlm+781wd+YbhufyXk22T7eC+jJoOZ9BrtQJPDcelewrgP7cnnO
         QRPTslcDNfztKWwrV4nPkpYYL2BJG7SRIKKENLy0cw+JB99aLIFkbN3/fvA2UQoTtbtl
         4FJLIBtcqIVPHk07u9RVqjzMyJLl5e0tAOXepYYW/QV7IZoJmaryEWBCDPZvPBDzevbl
         6XBQFS0kbQVgZGlJVDqIDKbWMKHIgm8dbw+zqDjd5Zr3IhU1iAZ3aHt4YeoyItj7BPd2
         SNW7s1dc3tvntnHDCfoqjtyqGd+gGK2p2Pmi8NXYPPPpy6+erUH3RjApk8yiiNSr7geK
         Z2BA==
X-Forwarded-Encrypted: i=1; AJvYcCVY8FKBNavbofTfxQL9/fq2mlqQmkFVw/RDooNTpsWWePEuc5fBTnu3azt5/NYF6Jmi5kO8bq5ptyzOGpszrUdq@vger.kernel.org, AJvYcCXj0lDf7WV0+VxDA8Q1qqypKN6BM/hMouzb0ja4WkXx5zS7Ur9jP+7DN8IsgOU7HRrKIz3W34B1YsBEZic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwbQ0ZWB0hPQvIYAit1tia8w9N7wXd4LUUeWnhUWB+izjXXIt
	dUDpzbUoWeHrkLEGhdR7SnIH5kAk8Y5B7s8Y+CDIPBViSegXeITo
X-Gm-Gg: ASbGncsfD9H5yL6W82Kcx4ohAwB+/dW7X4mfGTvlBE7V0NG/e0Mp57TNWG+r9eJo014
	5meZ2Sorf7oW7OYtZsrN3fZznCI6RUWGOkcsN4ptuTC3ndENtwWGaODy3EtaEmW8Sex10Qbnb6O
	gTaL6LX3MOV2YunfV9MTX5A8irCgyhsz/D/+uHewX37ABWId0nP/R1QpUGePYIR+whWAFyqAbWO
	giiWhnA/0VU+QRNMHe1HpFCUFKuz+t2S+yFFtOocqzP2Z+yKTUaNnfsnuCEzPP3ApG78z2O9Ujq
	XvvNMfmQ8HPtJtBqYVlI
X-Google-Smtp-Source: AGHT+IFgc/2Cf3s34iyy+3E1k6hm3BL9JT+SafDKeYk3hGm+IO82RaUKZZEEHoGVi7fxL60DE8Ad8g==
X-Received: by 2002:a05:6000:2c6:b0:385:f847:aa40 with SMTP id ffacd0b85a97d-38a8733a209mr26139393f8f.38.1736874254872;
        Tue, 14 Jan 2025 09:04:14 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89fc3sm218569245e9.30.2025.01.14.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:04:13 -0800 (PST)
Date: Tue, 14 Jan 2025 17:04:12 +0000
From: Stafford Horne <shorne@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] rseq/selftests: Fix riscv rseq_offset_deref_addv inline
 asm
Message-ID: <Z4aZDM1i6D9KKOI9@antec>
References: <20250103040326.2603734-1-shorne@gmail.com>
 <44f202e8-dc35-40aa-8dc3-2f2e4c28feda@efficios.com>
 <3bcdf139-81e2-4ef3-8e86-1e22b4df6d49@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bcdf139-81e2-4ef3-8e86-1e22b4df6d49@linuxfoundation.org>

On Mon, Jan 13, 2025 at 03:59:24PM -0700, Shuah Khan wrote:
> On 1/10/25 09:22, Mathieu Desnoyers wrote:
> > On 2025-01-02 23:03, Stafford Horne wrote:
> > > When working on OpenRISC support for restartable sequences I noticed
> > > and fixed these two issues with the riscv support bits.
> > > 
> > >   1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
> > >     passed to the macro.  Fix this by adding 'inc' to the list of macro
> > >     arguments.
> > >   2 The inline asm input constraints for 'inc' and 'off' use "er",  The
> > >     riscv gcc port does not have an "e" constraint, this looks to be
> > >     copied from the x86 port.  Fix this by just using an "r" constraint.
> > > 
> > > I have compile tested this only for riscv.  However, the same fixes I
> > > use in the OpenRISC rseq selftests and everything passes with no issues.
> > > 
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > 
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> 
> If these are going through risc repo
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> If you would like me to take this, let me know.

Thanks, I have not heard from Palmer yet regarding what he wants to do.  I will
send a v2 aggregating the Reviewed-by/Acked-by hopefully that will help.

-Stafford

