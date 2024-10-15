Return-Path: <linux-kselftest+bounces-19689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07899DAB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20231F229EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4EBA4B;
	Tue, 15 Oct 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6aYkXW/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3818E2A;
	Tue, 15 Oct 2024 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952722; cv=none; b=Phuyy63iKuPvM39DjefZiRY3M1xsdO5r0ZKwyBdHivI0rajc2yMleOquTRdOnv1bFC/PuTu8cKnKq01nVPMfK+HBRWuvYqPSUI4XhFJ7b0afwjqbCytTyfRtppmPwSPFPsSxDjnGtpbPtMIZZgV+C2cnZl6uekrJXv1cap1vNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952722; c=relaxed/simple;
	bh=pOAeSX8kJz50afBssThkJp87imIDyOBDRTPf+1RjHG4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ch90gwlPbeersnwmMY2bWt8SN+QQ5qJUtBsHHE/t2k6f6yCnDMgvNpZnIeaQkYj8dYfJ/Oc5H0QnysZjQc142d7iqMY0XfYGqNvZ+A9pRJBqLgb8qawwSaysozuwE2n6w4Cwa4U9FQousO8KZwW4XIGD2fVLaZc2cR/p1TXOtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6aYkXW/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4603b835a1cso48741831cf.0;
        Mon, 14 Oct 2024 17:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728952720; x=1729557520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQWJwOdFi41iaCsq3b3GQuRzgQ8nmghW67IzLzPlQ2w=;
        b=K6aYkXW/VMzIK2QdbbQHkCgeOaM2VJ/iIFxrRZ7KVwZ48fcN533zrrLxGe+3dqIpzs
         np1qt0pCiOqKAfmRwKkb9kdHAUec5DZ9Aof6xjVotG6JqsnJ3+Dws85eyc/KutE6/jY4
         +KsvQ1Yk3B47BgYJ92WiJhwbpeejpYDkz0NxKSRJk3PEHO29Aw3fK8voRf+Pqt85IPeJ
         DwLEJDpx/D4sU71Gx/v25BiVltPVI1XXgyfc6xlpDAUVFPKfDOSyU5zLqYcnQQgJzMbN
         Rh/DxNMU4asnTq60iIHyHQZ4prcy+5eA92hN7ItSBYxY14oGrn/yBs2QBXWsS+crOHss
         BuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952720; x=1729557520;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQWJwOdFi41iaCsq3b3GQuRzgQ8nmghW67IzLzPlQ2w=;
        b=DWzAUMnfMbqldtoK8+TRvw3RQI35ltTPZE+WIC5vUiwCr+LUnru3bYENnAJd1JE8Ly
         Fcv18eTgA44n8CFvocGhr+bEGirFjfbcpKhs5yQzc2DV68txafNM1n/ewnUFz0OvvPop
         Xf+O7uUqi4gHJJEC/o0AY/1dYjyNyIRTsW9eDrAUPGV2R8tt1U0JUKjzV4L6x1Xf57zZ
         QTh429okkoQ5eNXsI78p5ou+XzB2Pc27mNfMgd0twKUsL7W+n1Lbf4M5Znxaef1+Ay/D
         GRWh84iw3pachl0PwI5cP28ZF0Flkprwphn5cm5OSBlaq+VluOKF69ALMk/jO21fjFRL
         Kasw==
X-Forwarded-Encrypted: i=1; AJvYcCUMalLD0+HRV5DM507NAYqoajwtYrxrZT11Y/JTmmg/LJcCl//AdWnz4WdRhK2fRtcdb4POUA3OYfYgrnRDEPtU@vger.kernel.org, AJvYcCViutH69ZrwIAvprUlHBjsbPSXrjsXlbMTYbdxdiVu0tcWvqgPyJHn9moVjZkgPeVmh9cH+he/NQGqqRe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9spwW+62T8sqxIySTVNMwSpJBZlfdhmSQm56aF8323lL5gic/
	p5JGt53SJSCLCDuK7blPbcGiqOCR9ayw8AF7Mc1DRnsIf5KAM0Zx
X-Google-Smtp-Source: AGHT+IEoP077iNfP+W1cvf0GddfLzWqKR+2Nkpscrnepkcf/0XwTm7XIebaLPTK0xZuF+LahpPyYsA==
X-Received: by 2002:a05:622a:110a:b0:45c:a613:65b7 with SMTP id d75a77b69052e-4604bb94e7cmr210071281cf.11.1728952719632;
        Mon, 14 Oct 2024 17:38:39 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b378b34sm939441cf.67.2024.10.14.17.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:38:38 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:38:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <670db98e775a5_2e174229479@willemb.c.googlers.com.notmuch>
In-Reply-To: <4f1a3c37dbef980ef044c4d2adf91c76e2eca14b.1728802323.git.gur.stavi@huawei.com>
References: <cover.1728802323.git.gur.stavi@huawei.com>
 <4f1a3c37dbef980ef044c4d2adf91c76e2eca14b.1728802323.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 1/3] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> PACKET socket can retain its fanout membership through link down and up
> and leave a fanout while closed regardless of link state.
> However, socket was forbidden from joining a fanout while it was not
> RUNNING.
> 
> This patch allows PACKET socket to join fanout while not RUNNING.
> 
> Socket can be RUNNING if it has a specified protocol. Either directly
> from packet_create (being implicitly bound to any interface) or following
> a successful bind. Socket RUNNING state is switched off if it is bound to
> an interface that went down.
> 
> Instead of the test for RUNNING, this patch adds a test that socket can
> become RUNNING.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

