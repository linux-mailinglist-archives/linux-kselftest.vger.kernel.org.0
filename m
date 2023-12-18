Return-Path: <linux-kselftest+bounces-2137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD42816983
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDCD1F232A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DE134DF;
	Mon, 18 Dec 2023 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5ZYcSVk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12C13FED;
	Mon, 18 Dec 2023 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd86e3a9afso874207a12.1;
        Mon, 18 Dec 2023 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890707; x=1703495507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oamstZbN15K9v7B2Yii8F7ZBVCYFkDw5e8OQEaBwsXY=;
        b=X5ZYcSVkgLm+BfPqDsDuFi/Cfxz9DHvR6wSxsjrK+zu5wLAXNonugMjVwyACw6iriW
         uzlQA2mI5KKJHDbpwdm/ipyA2SefpllT8qtRwJ5RNbeXSWUa+b1eDlNR6zv5YBLxrRub
         3wSMr3Lgi4aS5FlNeMqafD3LCff4gg5Q5yCb19KYy2hqX3v19nbmsCqdDjqOyTe2laAf
         yfbvzbVS0WOiNI+AjUjLIrMgWLXynCnxouH+4YtlhtfgMFUh3hi74DsqlBQQRXvKUAHQ
         9I4zTjQ/wes8o14T4PABPkUtlDonp2yyy3e4CYYBlTcQZlOKh/vi/wEnL5r6Lf+ULZYc
         FJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890707; x=1703495507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oamstZbN15K9v7B2Yii8F7ZBVCYFkDw5e8OQEaBwsXY=;
        b=ZOoKarM/gpBziyIggoPkXvw/bggLyCqtywMwza820RvvP5JP4ki/Ew6+W7+CwNzd5w
         VUnL2/2zbDTc4bmyfKZfVA/EOE3Zo0iEPvelISImqaFSUW5wmmqkiFcV8Byf5upY0VJg
         pE+ypiZbi3JG4jUBo/d5FGVHlmMLhNsoIJfvuw+qPMb6lFmqYwh9o6RLGlZTixr8Vr3H
         MjjfUg+DQ/pN4wKuixEh2ttEmaP3yWXZqvozQsVUcwZG+xYLrZhQhXim4ZmEP3VlgZUs
         0p0pwKVKTfPB4e5pd//h8V2Tk+iXrhzpPHI0xNgFMQdVqQvOfTzbKJX9r3kGZyQneXYa
         zYBQ==
X-Gm-Message-State: AOJu0YyULc8+e17hMxRas1zQ93hsjg1j2tOA6qGfh5iEGUiP1PivXF+N
	AMCdWhbCP0R6cf9392Q8gg4=
X-Google-Smtp-Source: AGHT+IElrdFe1Jr/qc2kdXlQQjkbrR7DD5sZxu8ga0fhCiDmugYYPl+QHBGUROH/AsmUlShiz8S2oQ==
X-Received: by 2002:a05:6a20:29a5:b0:18f:97c:384f with SMTP id f37-20020a056a2029a500b0018f097c384fmr16245111pzh.41.1702890707307;
        Mon, 18 Dec 2023 01:11:47 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq13-20020a056a004b0d00b006c3069547bfsm17626092pfb.79.2023.12.18.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:11:46 -0800 (PST)
Date: Mon, 18 Dec 2023 17:11:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 10/12] selftests/net: Add TCP-AO RST test
Message-ID: <ZYAMzMzWa9PTUpLG@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-10-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-10-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:24AM +0000, Dmitry Safonov wrote:
> Check that both active and passive reset works and correctly sign
> segments with TCP-AO or don't send RSTs if not possible to sign.
> A listening socket with backlog = 0 gets one connection in accept
> queue, another in syn queue. Once the server/listener socket is
> forcibly closed, client sockets aren't connected to anything.
> In regular situation they would receive RST on any segment, but
> with TCP-AO as there's no listener, no AO-key and unknown ISNs,
> no RST should be sent.
> 
> And "passive" reset, where RST is sent on reply for some segment
> (tcp_v{4,6}_send_reset()) - there use TCP_REPAIR to corrupt SEQ numbers,
> which later results in TCP-AO signed RST, which will be verified and
> client socket will get EPIPE.
> 
> No TCPAORequired/TCPAOBad segments are expected during these tests.
> 
> Sample of the output:
> > # ./rst_ipv4
> > 1..15
> > # 1462[lib/setup.c:254] rand seed 1686611171
> > TAP version 13
> > ok 1 servered 1000 bytes
> > ok 2 Verified established tcp connection
> > ok 3 sk[0] = 7, connection was reset
> > ok 4 sk[1] = 8, connection was reset
> > ok 5 sk[2] = 9
> > ok 6 MKT counters are good on server
> > ok 7 Verified established tcp connection
> > ok 8 client connection broken post-seq-adjust
> > ok 9 client connection was reset
> > ok 10 No segments without AO sign (server)
> > ok 11 Signed AO segments (server): 0 => 30
> > ok 12 No segments with bad AO sign (server)
> > ok 13 No segments without AO sign (client)
> > ok 14 Signed AO segments (client): 0 => 30
> > ok 15 No segments with bad AO sign (client)
> > # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

