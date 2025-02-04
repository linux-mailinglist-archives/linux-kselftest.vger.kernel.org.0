Return-Path: <linux-kselftest+bounces-25697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A42A275E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCEE16698B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16178212FA6;
	Tue,  4 Feb 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7EhirCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67A2C181;
	Tue,  4 Feb 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683163; cv=none; b=ft94JTOT0VX3wTyis/9D1D0WGMAXolPCiOFf1lLO3npmTyqUJsbLtKpxVhLNoXewdVwk80gghgWN2F95dq/siKonHO3vrY98W2qT2wBCPkKdL5mF8bh7/rcFaKl7j7LD2JNMN1pNrbJS0QNl0wBGuH2NIDlf+4njtQ8STT4wooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683163; c=relaxed/simple;
	bh=Qo3DDIGJtcUGuWh0T2jAQbUj+hljTrEWamF0Lar9uH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl7rUIvyrIRLXKu8uFRnrysl7PgCF6I22B+fnbquplHOa3zsg6cyr/aZb3UOTQy4dvWZ8uMW/mAEmUejCFW91wTA7cwYSZRRZf/tRXcHe+JW8V8ZCa1z609/BBC5QKfr9RmJjIwzlDcujcDH8bbYuS3Xx0POVJ+3OrSDNQNQJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7EhirCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608D4C4CEDF;
	Tue,  4 Feb 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683162;
	bh=Qo3DDIGJtcUGuWh0T2jAQbUj+hljTrEWamF0Lar9uH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7EhirCGEyJjHIGdJUI7y+A+Rh7Q2oDrSgBfxC0Auhtw+Ztp3XP+k+VYVWpd2vJ0Q
	 m7YEs+G6AIw6CpNYfnzUBE59keIlV82eZgJbdKNeNWEwAlTjxBG7qqND1y8R1o5R9M
	 mHJ3BY13k1uvFJ36gkJEk00sJqt8lPUVEBXiaSm7fHsAjpBSk6R7oyc4ijQNdxswHk
	 +apjyCHe5ePWS8ADM7VhMMGHRL1+a6goMk3fr1B3uJdeozs0+u6W3n3Y7JbFPB8dzs
	 c4pe7kaCDG9rO3PQPo0P3wtDQ5rJsA4fRMMJxOKafObJdPj1FUcQKSVFbVq4s2Md+F
	 DkfGtN8H2mFFw==
Date: Tue, 4 Feb 2025 07:32:39 -0800
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 02/16] elf, uapi: Add definition for STN_UNDEF
Message-ID: <202502040732.FD3AA615B@keescook>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-2-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203-parse_vdso-nolibc-v1-2-9cb6268d77be@linutronix.de>

On Mon, Feb 03, 2025 at 10:05:03AM +0100, Thomas Weiﬂschuh wrote:
> The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
> To be able to build the vDSO selftests without a libc dependency,
> add the definition to the kernels own UAPI headers.
> 
> Link: https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.symtab.html
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

