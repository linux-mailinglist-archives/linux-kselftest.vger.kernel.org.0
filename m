Return-Path: <linux-kselftest+bounces-4568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F338C853926
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94071B2A6E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAEE605A7;
	Tue, 13 Feb 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpC68EKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459860864
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846924; cv=none; b=MWscE3Yv7K9Sm1msO+fofnJgz0IEqcdFBLrNJsbEe04sAFfKQIFGIQpR1jraZ0E2gIKkgvTQw5yysRn6Tz0fpue6mTuN/KPIhXG0a2+E8OAGaMnhBzjm03Z+HA+lNeDlHVQpkdglFVmLy72Z/j/EGuRN6ugJ+nEDv/MEOIIb1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846924; c=relaxed/simple;
	bh=9tA4PJNIdxfhRObvzKWYDSHnvWdGJLyxyrK7xpD4Q0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv8rCDr9IK7RVL6MB+YR/x4FZb3tD3MyXqGXGTGI9Vqqp4ceZh2iRWxylpquGYB5Ij6stUzB4G/JhD5vhnn1Vg1VWX4VicoBM37qb0yyI0UEe+ViavNChq9jtFViCNu2w+GxQeu+G+Yu/kP01dUzrxzg8Kk2WDlT78WdpPIQnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LpC68EKv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2ebb3a1d1so940067a34.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707846922; x=1708451722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHH6DgRGJUK+K/3+G3CCr8FcJttt2bs3BQjcG1Lrj7I=;
        b=LpC68EKvpNG3B+MXWAlZJkJSQSfOCnEgSQKbm1OLenEyOOi6uilOcCotZttGDqYIzo
         XalLZCGsKa/vqu6pgUc7pFQ6V+qB0fXzf/iHnHVjdFGDNmuZQXLHDXId+yHhBrnmzygT
         s1wdshr5pb+mDdfjc5tmcq9UDZu1534S2U3l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846922; x=1708451722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHH6DgRGJUK+K/3+G3CCr8FcJttt2bs3BQjcG1Lrj7I=;
        b=CEq4U6u2mu+Oqcd5U4RGJ0eG78CrTbTWDvd3yUf9zXg4v9PI/3jNdy63Ytb1qVrjwK
         GNWADeXD/c2zTQn0UA5ZRuxGT10xcrDFsaX7B+d0GBuXT9adCJcPaPR/Ii9D2gRd4CIR
         IXFHO9cKhJoj8rMD4TFB1lpob4/dDWf3B0kiJYCtt4RF1plTGgqRzTXeKS3vk5vsAM+d
         puNT2SMg1eovR6Xzx1c83RwYewAfYfjDxqy2W9Fq3xbwb4S0Bys88LSV64bp9t6CPby0
         H8NFW29h6AlFYSfsctxhjt71zXBTi3k2Zxr2Iz/4G9r3UXp1gFIM/VxCPHaAMSHJR7cY
         uy+w==
X-Forwarded-Encrypted: i=1; AJvYcCVhdmAsLsC64mtwjz6bI+pxwlkBtxjBS7Ry75hdsN2ZSDfy81GvgmLjLVdhuuNkJ9R69+Mm/u1jIiXiYW2dGgYslfWdik65pCXXOLJ6xTtA
X-Gm-Message-State: AOJu0Yyyq0pnz+L1Aqu5WNCNTW6X7ioiTy5w+G2Ww6myKl2aKKRmf/VC
	2K1ucQ/OVpwRf/jH7BIHSInaZAf9bRlBfiDndeSJtgI9OUUyPSbE2iqMnGzNrw==
X-Google-Smtp-Source: AGHT+IGYNxQGH8ux7gJ+l/xnGKzAZ18uVxeJixNqeVsBpC+UP5JSrjoZlL53WQFEfiii+ZAKwUM/sw==
X-Received: by 2002:a05:6358:2811:b0:178:c51c:7af5 with SMTP id k17-20020a056358281100b00178c51c7af5mr12691366rwb.32.1707846921875;
        Tue, 13 Feb 2024 09:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWkmt3IPXDuEj0zOlfxz9ExS0oa+gkwlj43/jOtMEPQLoiRm1RxpOFHkrU67ii1euE+S+sAya0midSyK9CryTNj+Fv/cbP5L1TWpcqDVBPLNdtr97DrexutBhGU/EyIZp4C3YoIF3I5IyunsfhZaAJLovT5ei0/C2iR4xmNw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j191-20020a638bc8000000b005cfbdf71baasm2693461pge.47.2024.02.13.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:55:21 -0800 (PST)
Date: Tue, 13 Feb 2024 09:55:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 2/4] selftests: kselftest_harness: use KSFT_*
 exit codes
Message-ID: <202402130955.8A2B2B1@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-3-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:14AM -0800, Jakub Kicinski wrote:
> Now that we no longer need low exit codes to communicate
> assertion steps - use normal KSFT exit codes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Yeah, good cleanup.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

