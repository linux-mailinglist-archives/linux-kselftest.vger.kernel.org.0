Return-Path: <linux-kselftest+bounces-22385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CF9D4541
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 02:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6570282572
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 01:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E92FC52;
	Thu, 21 Nov 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9eODPBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAB2F2A;
	Thu, 21 Nov 2024 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732152346; cv=none; b=CgCBb8KLxF9tS00bFoT48RpSlnNBtaSCkF8vbaTk1tCUf932egHbodyW1ZrUgiTBICHiTISEhzx1CW7Lmm9UWkHwl1st8VMoavQ0la10pUj2vaEs2A3YtX1k45tzjcJWjAzUFsz0yET745Q6majFpREsbf1A2yePVbY8BjdzvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732152346; c=relaxed/simple;
	bh=xvJHuxN9St/qqGCISU3aK6X3sWr74wOx7oQOb+QgKEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huP4Zhz69bB1pLNejW93G1rnBweKxZlKG7t8RjFunaj8qknTe8rR6LBM1+OvrBAqaZnvpsofFUkG0DTFnYIJvkGZE+RdILsG6oZAeSA/WM9OJYEHzVPqdpU7TBoA7O65apteRyRFQf6xG/uDMxftfQxBUv+p6YWGZaJvkzIv0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9eODPBC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso354184a91.3;
        Wed, 20 Nov 2024 17:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732152344; x=1732757144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcl32RV9k1qduJDWQ/zWpkC8NvRU5+ci+GcHLWbrsSo=;
        b=l9eODPBCxGMp1bB2jpLjPmlvvOq/hWErpD9NmBPiprbVGtLtTEQHnI/aSOJO73+sB9
         rcI1JvETeEfxFosi964MGi0lgLqwC2+uKU//OUstwJ46gGrW5gT6aNdvptKkgO+jNYXj
         Nza/biBlLn3MYhesGp3Dqmi7Im50evxIC22CphqdXgn096CGCJob3nSHezhJGWlaxees
         PDMw0Rp0KA0vTWbKhzbLwojlAhUuCY4RjmkXNSLwVcNe3sGaDaWOJjDXi8eBhymLVvbi
         kwOPLrW9r2QPdAqF+NcV5lCxEs0MTtBPQ8ucXzuJCHqcT7PT0GN4D1cnTZLqRqTKiK58
         8gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732152344; x=1732757144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcl32RV9k1qduJDWQ/zWpkC8NvRU5+ci+GcHLWbrsSo=;
        b=odP1ldkTxSN3hXTM2yVoBpcoK1C0mEjLHfxUelur4veQNLKcC8XZDH7aA9SodZPaic
         slf6b7zH7vjMMwqY4xWjKohDHj/9dNoODPXNU2+DNIUFMplJoB79+sMo38kV7wG+vxRK
         7Rzc+klD0jJ4o6WIXKc8fO99mTlr3urNc5HCvoibJCE3w4N65Lzl+aEm1mDkTvkqLEi7
         h7pFOMBLxmfD0+5ugE6QtJ86SdXZ0yOczfEb2wh5xqt6lrG9+8g7TKmv/gnkXJF9G/us
         ZmjqxQI2rFNKyT8U9ox5pgpQ8FRVaPzdQhpsLngZrO5QpIMFiOjz/ykHgkCgGgm64RR4
         TNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNrvH0iqVCxz9g2gCr4OxQOPc+8YArTdtb4LpbRcW2JDPiq7lnJijWQVf4g50BwS1q2lQtc6eZ@vger.kernel.org, AJvYcCUYNWZiLfUadPql75tLU0MLsRBpfZlMrlaWvSmHOaF//qawzL+wKWRMNNccRN+xigjrdcXZcKyRz25jOFrs2Bd5@vger.kernel.org, AJvYcCX21xSypJRKZHTHMNtyH6f7bS/FyoSS+Tq8Yt7wtpgNnml1PHlVzkdU0kNWuwUn3bm57Dare1v3E36r8xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznaNpdp/C1SiawIlvvJ5Q5lmN0fvfe+LOiLU4sMAGLkZ9fqsRP
	GPllY8PTGnDMDKV6V/gtrfQ2jLLQuZI4G7zbhiIeOGUbCsCEZw6g
X-Gm-Gg: ASbGnctpCudgj7WhwVXu3FRM85x5Yps6CJqscDbNPOxB0BwDWwB9uXz+vTUxwM+c7+0
	6n0sLjj4wh7F5zW2vQbFY9JpW3MvGy0X3aRaS+AS0uGBYf2G+iYYmjE1ITJ0a+Jj2sFJjt33vQ9
	pHF8lTA/BAazGPTXYehyMMxrBDE8rmAVREDDCc5Ab1e3JxOnFOby9xEQC2Y5TGvcl0jo7SNW3LP
	YPrM49y6m/XybgDKiDMkjVCHU9JclUseQe2WO8=
X-Google-Smtp-Source: AGHT+IHbxtSpOLCCWBe4aYm8HR4213iEzQzO3CI0mFE6HhbnopUM+RjkBNnbR/mj5cQsegw1jHA2tA==
X-Received: by 2002:a17:90a:fa11:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2eaca72c6c7mr5726973a91.19.1732152344460;
        Wed, 20 Nov 2024 17:25:44 -0800 (PST)
Received: from tc ([2601:1c2:c104:170:aeb7:1d21:ff22:f729])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883d3489sm1917395ad.207.2024.11.20.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 17:25:43 -0800 (PST)
Date: Wed, 20 Nov 2024 17:25:40 -0800
From: Leo Stone <leocstone@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next] selftests: net/psock_lib: Handle EINTR and
 EAGAIN
Message-ID: <42gn3eaqfcs7qaei7qf3nrtvcp3kztuex5ttcaahfntzx6hw6v@afsmwqb4xhmj>
References: <20241117225950.138968-1-leocstone@gmail.com>
 <673b56f7768fc_1ced1f294fa@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673b56f7768fc_1ced1f294fa@willemb.c.googlers.com.notmuch>

Willem de Bruijn wrote:
> Did you observe actual issues or is this based on the comment in the
> existing code ("Should really handle EINTR and EAGAIN").

No, this patch was based purely off of the comment, and the examples of
similar code in other selftests, e.g. tools/testing/selftests/bpf/xsk.c:

> static int netlink_recvmsg(int sock, struct msghdr *mhdr, int flags)
> {
>       int len;
>
>       do {
>               len = recvmsg(sock, mhdr, flags);
>       } while (len < 0 && (errno == EINTR || errno == EAGAIN));
>
>       if (len < 0)
>               return -errno;
>       return len;
> }

> A simpler approach to dealing with EINTR is to ask glibc to restart
> with sigaction or siginterrupt.
> 

If we want to handle it that way, this patch is probably not necessary,
since there is no specific signal I would want to install a handler for.

Thanks for your feedback,
Leo


