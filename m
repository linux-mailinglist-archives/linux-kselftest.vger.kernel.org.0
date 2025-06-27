Return-Path: <linux-kselftest+bounces-36011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF8AEC14E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572A03BD4B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728A2ED15B;
	Fri, 27 Jun 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti710WxI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA692EA491;
	Fri, 27 Jun 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057049; cv=none; b=h0LwTvOOY5D7molnf64xI4/+WYI1CuDW3ODV6cvlfLWRmLK2VmiRQvJ20TCDsHaZ8dleSXxtkyT59oRRIWRdVdG7UzxQcSS/OpJOzJcZtsMi8jAvfKFnO4aBhMPyKNGOYX0TmOMgKPXFM7khusSZeghUCTje8Ge9KdETu4Lb/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057049; c=relaxed/simple;
	bh=R/CIng+EJkDfU0uuTIEmn5mRPgf1sXrI2AIF5oRasqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0Gr9jTKuNcwBkIj6TBUUrfjz2LOU95ioKtebQMMoJ91D+BggFcUojGbaduI71Dibx0iTr4hX26XGYQ6SGHkVxix81fg5LjR7qPfUR/FisGudfLRjGS4pmZdd63LWd/94NIcZ+fhuuytJ0ykPxjQax18ygYVsj4yTmkS00/bicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti710WxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21BFC4CEE3;
	Fri, 27 Jun 2025 20:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751057048;
	bh=R/CIng+EJkDfU0uuTIEmn5mRPgf1sXrI2AIF5oRasqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti710WxI2uwyE/dfH78f0XC/yO0rUZofhHRYrhy2Qr0Quw7svTOqt1uSb17+XKuN9
	 rP5PSXb46OTKz2WCx0izerOptMeUtYgXnGObf+iB9t+AwJvOuykW9iAkKll35el7qo
	 3YoO0Z5vkgwVyGRTqwBhUo9de8hY8EJ3NsbPl3zy8XbEKKcmqblqr6q6ndzIw3jYa6
	 so4PSzZ8wXW8EaLEdAM9HAImfhByDkzWU8E51a049Ykz9Q+7PBJRiebCxqV475dA2k
	 X3+m1TQQ8TflfEsDDf5XJ8FZzr2R39MaYMEjmgFnM1d0Hk3ViV+0cf5a51w5TA+ZCB
	 8iLsg2oS1nOyg==
Date: Fri, 27 Jun 2025 13:44:08 -0700
From: Kees Cook <kees@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
Message-ID: <202506271342.8913E9B@keescook>
References: <20250624231930.583689-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624231930.583689-1-seanjc@google.com>

On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> of the same name defined by linux/overflow.h.  Note, overflow.h's version
> takes a type as the input, whereas the harness's version takes a variable!

Can we just update compiler.h to use typeof() and drop duplicates?
(typeof() a type is a pass-thru). Totally untested:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6f04a1d8c720..cb925b883806 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
  * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
  * bool and also pointer types.
  */
-#define is_signed_type(type) (((type)(-1)) < (__force type)1)
+#define is_signed_type(type) (((typeof(type))(-1)) < (__force typeof(type))1)
 #define is_unsigned_type(type) (!is_signed_type(type))
 
 /*


-- 
Kees Cook

