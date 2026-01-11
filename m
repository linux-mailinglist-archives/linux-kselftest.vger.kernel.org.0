Return-Path: <linux-kselftest+bounces-48691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D88D0FA00
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 20:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE7C430123CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49A352C47;
	Sun, 11 Jan 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3nGd6dM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C78219FC
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159014; cv=pass; b=rDmZCKtInwGc0w/vfeo0vIem/4pf/cStP+OvXaelDLYAZwa/mjwWqYLe2WRnoFa59QfoT00om/L2W0oZ8F5886IxCdfU0AEaerMlraj37mV5BJywfJ/2OXp+asLrJjtwVf22VryjrEnTFbOeSJ4avgxlJKtRZR27PwLdwYbk6Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159014; c=relaxed/simple;
	bh=GK10uFFBfJnUN7pJIA3veOdTRXwgC+DVFIf9jpvuer8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq8zxXXdB9xgXQtF6RmO/l9zgdpCfnngmB4v6uYH9c+DhudHmuykmp42AaJ9z3uj8JTXvgoscv0kA8X5rBviO4Jx1bJXnEctrpgocm9/QJ1UAQ4T7p3G/Jr2Byi9Vf96PbBmi7KTq4GTHe/bMoSPEUXUkdvwpWUtojq/XnW06hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3nGd6dM; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b6935a784so3686e87.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 11:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159011; cv=none;
        d=google.com; s=arc-20240605;
        b=khJYjAEmWIue8U/vbF77ZnxpbNJhpeyvvW5wuE4rhXMHxS5RoGsnBULNk9lW88aZQ7
         7wrXgDqx8G3hlgP4p+h5OYpcebQr/fwQILG92rZOTFT7xrlXlG0NcH0Gn8mBL8/jdg9y
         qLptbcilx+dxu1xVuk2ya5GbKM6cxCaseWKaw4yohuzh0tZV+HpiOQJbq6hzOq8TcVn6
         rkhdP2795D471DjcFdAVUBkihphRW8kUCEZwWTiNEdgdHG4vPktq869gu6lwiOM/5mKn
         fy6n3uGUnS320Hn4lt2bvhWk7GPZgwd2hqfM0pWWYl2/anMehw99GO58tS0ouIhbNcIJ
         ikJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        fh=ezkCngVdr256hYmV1zhnJ7aPfRs/9Is8XcdKyRUbG9M=;
        b=WVCxcToEptWVxItEaO6i6USmA8uZSq4Qt+AqGTot+nvlbh1h0zHIJpVfstdjxrdMwS
         eXsDnFUjHPZSA2R/H9OsyHYs+cwKz2rkmMG1waRhL1n5MKbmP8DcRKPZJ6Gnpz//Dejf
         5s2ZiDpZTaenIYn2dnt/Cfv+sXUCOpSXjSzQC5PrzeqO6XE/rXHeKCQlkJyQ36cJCfJU
         lTzWow5XhLIkZrYuRZRSzYgpm60mQ3XGNYgvuKguAplkDsNCmGH7ZBa4J7IXWNIsxhlb
         wvhXxYpDqigF8NZzDRFq3dMo0tW8S8U11rfJ7FBy06omBDFMNjh7HIGkDNvvv4W0MRsQ
         8Pyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159011; x=1768763811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=s3nGd6dMyfhoMdv06lXdfkER/JtrT4HoSJ3vBu4za87ymCF/PBLC5nvDIxAuN6vsVi
         zKQpw38gzADgTLZm1Hfp3800313WuCaiBz/opRLKThuXvyl1duLUOnfbN+aYVRvWEknR
         ETxVCM0Sr5bJnX0r293bgI2EEK669HhP9l+g8D3KvulVWa3/Xm6JEcvmGemId3A6bKBW
         356/bxF6No6IkFZKkcsySU++qElgUj50YuSPYHcGcaEiOv4IhJgtznkk/7LiPUmB1wLg
         QBRFi/hOeRKW9RocG2pnUZIsR5IlMf0v/okY5q3UHifrBjDGUcrYcqyiMoxaQVTRHtEQ
         WL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159011; x=1768763811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=ho+BUBCpwvWfkw0cinp2AGVQDSGr+W7cXF2qa0mvddMCJnygnDVMhKddP0dFsxTf1f
         u9m3BjuzAqiOQuwLkkCOvsjwNT3miFCVIGeC6mc4a9eFBEqfisWeClZM8hMOYscHaZoJ
         5qAljcudq86I73sCkuZK/i1Z4/Pf6KpAV5/GJw0CpVxQzVquIWExI/47C9AKXz02cbIW
         mfpOLYyXmtgYFWEltfcXaNnfbeSMg+w/J/U5uvICCXKe18FOPePKMUmObEgdBB3VZFHr
         pfrEUOubJ9TTK/U09o4Ebls58zSyfJV1tJG8lcm2U/32gRrmYtePS2+gekJN6vsFFan7
         Jm2w==
X-Forwarded-Encrypted: i=1; AJvYcCWW9hBuQ0gTtwfdmvjb9bLZhVO6hHBNDLYZ3RpW4nNG7pJRIkRiNxbJ3WpiNX37gm+JLRJMxIS/bUXNaBXYSQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRafNn8r8CpmBJC5yqDvOluI115c/PtGoMhG5gBKdjM8R+LhG
	POdi5dEBNBjMNaCJFbNoVNAweLya8o83SPPirkT5ndCO3aaVAyflNK27jY9APt9j2frwIOLWpTm
	X8s4AbhAMUiWasdNBoV8QgOOSorokEo27m4jR9OZv
X-Gm-Gg: AY/fxX6qYdCfavxk/ZNbxkB2h34zVqWHTgg3iecorYYvJQvNuPkoSIuv4dT859tRloB
	Ha2ZmKnybM+F3G/rwrwo8H5KSqi8OkZy/6dR5qQXu16vhKdi5EldBkhmW+MYHJzql7pMBxDCee2
	XThrRi0riS1s2w1gGde+prcPDP8zgjhqz6Zn5vlGbSiunMLqDoJiykvXtd9m4dlDltmNQ5ExkEY
	gT5dpuHdlNp7B4a5DcUT2U9dWPt4jc64eZxGqB0RpaA3PDrfETgOjYKrrC6QlK6E7gRW+Y=
X-Received: by 2002:a05:6512:1288:b0:597:d606:5b38 with SMTP id
 2adb3069b0e04-59b85911648mr136353e87.6.1768159010781; Sun, 11 Jan 2026
 11:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:16:37 -0800
X-Gm-Features: AZwV_Qir-cv-IZVpPXwaBdmvkArrdmGky4-Qr_YMN1JPM7e8jq7epyBCPXxohO0
Message-ID: <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add test case for autorelease.
>
> The test case is the same as the RX test, but enables autorelease.  The
> original RX test is changed to use the -a 0 flag to disable autorelease.
>
> TAP version 13
> 1..4
> ok 1 devmem.check_rx
> ok 2 devmem.check_rx_autorelease
> ok 3 devmem.check_tx
> ok 4 devmem.check_tx_chunks
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Can you add a test for the problematic/weird scenario I comment on patch 3?

1. User does bind (autorelease on or off)
2. Data is received.
3. User does unbind.
4. User calls recevmsg()
5. User calls dontneed on the frags obtained in 4.

This should work with autorelease=3Don or off, or at least emit a clean
error message (kernel must not splat).

I realize a made a suggestion in patch 3 that may make this hard to
test (i.e. put the kernel in autorelease on/off mode for the boot
session on the first unbind). If we can add a test while making that
simplification great, if not, lets not make the simplification I
guess.

