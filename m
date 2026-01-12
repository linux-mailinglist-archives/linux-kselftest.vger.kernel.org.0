Return-Path: <linux-kselftest+bounces-48792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7918D15237
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E69EF3016AFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD89328623;
	Mon, 12 Jan 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfXGBlJr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B5237180
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247799; cv=none; b=E1IJnSmxxAjRMDRLVd46KyE9028ntiof74E8FqB7FUmlbq86rMTHe85OBpfPZDQy7frrrg/cd9czgn0yWCR2eiNHSjeuyf3KmKFdIv+EgIBv0ICBkn7llW+ZH12XkXH/PWgtZew1E6Myp6bHooJOZQ+qL4QrJcd/ztdiQat19RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247799; c=relaxed/simple;
	bh=M31+Y79zuoXr1vFVcVS4+r+feGloqOn2T9Swnz4nHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/KbsspeRrJc8jumKsYiu+GtI4lUMae1lN+SvyZIF8YaHv8JEhXWXSX6SyvsGi1b28yqgMHNAOjRCeR9lHgpUa1QFn+JxrcC58DQQikWUFWSBBRikADetAHCX5uF3JM0LyYb2oTfOsIsAGCzi1oNH/AR6UzmxYq3QdY54Dhhp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfXGBlJr; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6420c08f886so9489467d50.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768247796; x=1768852596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KH869nzXNgoUvJaMyA9BtLsL3ZEwdxgmckhbEXHR+og=;
        b=JfXGBlJr2osxbGCfOatR5NPxF/H8VMPOSfZ9C13U+SqbZ8hRSf7IpFZ5vVZZZDvYy+
         2VSYW+xuO9Bi0KdQQnnXccSV51JR2vcgKPJFjSAlJ0mpQSEBEmC2x87Vomfoyg1OUrb0
         eUpgCWAHD10emPytH3FHapE0liSihz2Qj34/ht62jJUcnctbeBSiitrQwmQTvbhTXwr3
         uazflyT+HRwx5fjoj3Xrb+nPgejigD+oJwC8xPgaflNl5yKfA0QQD92+xlRKPuwcKfOD
         1Bvtzq6S9S2SfotgpV6P+ZOSzP61PwYVK8gkBBYcA6/AJSGj140dh34N/VQVWs7JOYyN
         uhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247796; x=1768852596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KH869nzXNgoUvJaMyA9BtLsL3ZEwdxgmckhbEXHR+og=;
        b=fbBMzZMyeZbziz/4S6XhNMrwRQ1zuHieQpkwBiGebCc4+29QXmlzfWNydlgCYNEjL5
         4LOLX5zzxnamvUsLBDi7boPDmVmd6l8OYWSOMTFgtTOppZszxsmiVZXtiH3iHB1j02ga
         /yuIrZTzT3xkHZA1vTrVg5uWEAUbOR/288SMiD4OfGCsntXgVbZzH3E1Vsiasu/WL46u
         S5V6M863kJB+Vhs4l8NUuIRJ7ygcMdkekt705jlTv+f11dxD8Vcp8orPDXcwrOu3Z/bW
         tzscQt7I6/6yyJxSfV00EvGi9JvmBCAiChRRt/McgnRhppNeQTnooWZXPtIb4bXZmIGU
         YgKg==
X-Forwarded-Encrypted: i=1; AJvYcCXLvCGbdOtPmR9C89LnefT34R7t2uf/9LwpyYyTdI/P0NVEChsfaaQTpj4t5b1wpn5ILk15zwd4xKcI2Wui7ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcaGQr0lBASDVZCi0hdUstz/6fFyFTqAJp56XMzatzZhp17hl
	gd6OjCahkLB5vzBRpifeA14BHiiaOqdavHW5uwX1negEdMu61zbCXmBM
X-Gm-Gg: AY/fxX6hErX7oBxpefzelMcQWZueySZbxHsbHs6XqroBRS4N9OnCr6p3gxnPX9H+eXz
	jIVjs3WZLPqvRZdxzOPTB8IWDkvjsLiDEQxdLwu/iLHdqed67MYaomLfVXMtI2f1ePUmX/c7hPI
	/N5eSZ94Ymz06l0Ev+sCzk1Xfc/Ut04JpFyU0ILfKS5nZIuJHs8OPkwq9RHNVC4yzaQm0pA+85Q
	y28XB+HeehrG0ZIQGrXZRFUgG7dTHzbjwi+zBf6BUksSxzUVHaHXCy2yp8XCXgz8l3EdOD/NCg8
	CzTsvmxbEcJX/Ux+rAzIinvXcjgF5w4i6pRLrTeDNJ9Rv75qmo0KwTLFaF7spyNB60fnJqNdC8+
	riZzLz1EnsDd0zv/eGQQNMjiBabkRSQ0eCbrOzeKn6jB9hIUY8hHhjsOaFgy9ydHbOp2/gZ1lBh
	U4XQYQ0oCjnyim13QXvLmYKrkhtHjsSCp26+8=
X-Google-Smtp-Source: AGHT+IHgu2lOJznxq2Oiaq3vnKy3dA5EnBV3x7HgHsvKXwndIU+C6LqpkznWacQVy1guDmkfDk9/Ng==
X-Received: by 2002:a05:690e:1348:b0:63f:baef:c4f with SMTP id 956f58d0204a3-64716c5a848mr15226065d50.63.1768247795824;
        Mon, 12 Jan 2026 11:56:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f76desm8366862d50.3.2026.01.12.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:56:35 -0800 (PST)
Date: Mon, 12 Jan 2026 11:56:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
Message-ID: <aWVR8U54fLB+mA/4@devvm11784.nha0.facebook.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
 <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>

On Sun, Jan 11, 2026 at 11:16:37AM -0800, Mina Almasry wrote:
> On Fri, Jan 9, 2026 at 6:19 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Add test case for autorelease.
> >
> > The test case is the same as the RX test, but enables autorelease.  The
> > original RX test is changed to use the -a 0 flag to disable autorelease.
> >
> > TAP version 13
> > 1..4
> > ok 1 devmem.check_rx
> > ok 2 devmem.check_rx_autorelease
> > ok 3 devmem.check_tx
> > ok 4 devmem.check_tx_chunks
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Can you add a test for the problematic/weird scenario I comment on patch 3?
> 
> 1. User does bind (autorelease on or off)
> 2. Data is received.
> 3. User does unbind.
> 4. User calls recevmsg()
> 5. User calls dontneed on the frags obtained in 4.
> 
> This should work with autorelease=on or off, or at least emit a clean
> error message (kernel must not splat).

IIUC, this looks something like (psuedo-code):

ncdevmem.c:

do_server(...) {

	client_fd = accept(...);

	if (check_premature_unbind) {
		/* wait for data but don't recvmsg yet */
		epoll(client_fd, ...);

		/* unbind */
		ynl_sock_destroy(ys);
		
		while (1) {
			ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
			/* check ret */

			ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, ...)
			/* check ret */
		}
	} else { ... }
}

... then devmem.py checks dmesg?

> 
> I realize a made a suggestion in patch 3 that may make this hard to
> test (i.e. put the kernel in autorelease on/off mode for the boot
> session on the first unbind). If we can add a test while making that
> simplification great, if not, lets not make the simplification I
> guess.

I think we can do both the simplification and this test, but in general
we would have to skip any test when rx bind fails due to the test's new
mode not matching. Not sure if that is desired.

I tend to like the simplification because I really dislike having to
track the RX binding count, but I'm not sure if there is a good way to
do that with making our tests locked into a single mode.

Maybe a debugfs reset option that rejects when rx_bindings_count is
non-zero? That way we can remove all the program logic around
rx_bindings_count and make it's inc/dec wrapper functions no-ops in
production (CONFIG_DEBUG_NET_DEVMEM=n), but still test both modes?


The handler would look something like (approx.):

#ifdef CONFIG_DEBUG_NET_DEVMEM
static ssize_t devmem_reset_write(struct file *file, const char __user *buf,
				  size_t count, loff_t *ppos)
{
	int ret = count;

	mutex_lock(&devmem_ar_lock);

	if (net_devmem_rx_bindings_count_read() != 0) {
		ret = -EBUSY;
		goto unlock;
	}

	/* enable setting the key again via bind_rx) */
	tcp_devmem_ar_locked = false;

	static_branch_disable(&tcp_devmem_ar_key);

unlock:
	mutex_unlock(&devmem_ar_lock);
	return ret;
}
[...]
#endif


... but I couldn't find a good precedent for this in the current
selftests. 

Best,
Bobby

