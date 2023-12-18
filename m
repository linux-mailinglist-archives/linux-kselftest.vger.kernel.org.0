Return-Path: <linux-kselftest+bounces-2135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C94816979
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E3F1F23210
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986B11701;
	Mon, 18 Dec 2023 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTS7Osbd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EA12B87;
	Mon, 18 Dec 2023 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so1314547b3a.1;
        Mon, 18 Dec 2023 01:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890630; x=1703495430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dql1SV1uP19+BT1pINCOEPu72ghCCyF47UofCGXSnrE=;
        b=dTS7OsbdK5gEQbMIETIQ6nGH/2wba9UoTmAiUZffIu7lpDLtX1Q+KAuK+4L4jdPYS9
         cTXfjbYvhlGUyPjdKOopz6fg6tIJGJJQvBVYA+23ixK0XLvM3uuan36nOZaZ5om7Ko+2
         +R3J9ubd8TKVhwdb4OgIondP+Kkh1JLkbd4uXde7Nn5BxLl6MLrBzgngcwXxp+AfHIiB
         BvIX7tlqBJk7iyQ4SuKtlTm1wRCKDxXyOHN2sOw+BZRV9TQOhAoD2VX7b4X3elHG4meE
         30d8TScZVtTP6JAf+PCdqKpWzV6kEw2cj1yXNQPjFpBZQAW3PQ9v143dofvV2PRbNqM1
         zN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890630; x=1703495430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dql1SV1uP19+BT1pINCOEPu72ghCCyF47UofCGXSnrE=;
        b=MPm4FY+fYI1vfZJW7fJYJ9Yz26tn7k4FRWG7b+5csirqP3kiJ74vBfzHIz1jdGzpdL
         xYhFlV56087oLQT2gi9H7rHCbHIS+qya1UKk2BcURfU1898zx+0/OZ50iqyTZuJ93jG6
         x6dSe9f9+CBbWYrf34URVYCIHJRiRQGCRDm2HTtxR3nbBfBacNh5fTaC+4fNEN9wkeFR
         qBFXS95/lHCmEn6ol+UFin5tMUqievx1Rs3FIzFdA0PpeVUsovLhWBHYMkAsYHOdW2Ou
         zD23+99AWoGhgIj2OpaIYXxaiHVDDVEZauRpCWHEaUG1z+eVBNAVxlT70axZIzIlo3pB
         n3bg==
X-Gm-Message-State: AOJu0YwpRXba9YAiqmB6eJr5hQQIIC6es+mtALdw64njUc62bmPkIr1A
	SzGZbkuI6X570/k3JFtuBiyc7lxEYxb38OWl
X-Google-Smtp-Source: AGHT+IEV9L76yhjSVSSUgF1uIxKEoUMcpb/vJVpky/1utup5j2eIU/J1nn+vxTOMZjxIwI5DB8sc2A==
X-Received: by 2002:a05:6a21:627:b0:190:354d:f90f with SMTP id ll39-20020a056a21062700b00190354df90fmr7370928pzb.117.1702890629683;
        Mon, 18 Dec 2023 01:10:29 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001c726147a46sm18523291plq.234.2023.12.18.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:10:29 -0800 (PST)
Date: Mon, 18 Dec 2023 17:10:23 +0800
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
Subject: Re: [PATCH 08/12] selftests/net: Add TCP_REPAIR TCP-AO tests
Message-ID: <ZYAMf-vwntB1FveW@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-8-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-8-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:22AM +0000, Dmitry Safonov wrote:
> The test plan is:
> 1. check that TCP-AO connection may be restored on another socket
> 2. check restore with wrong send/recv ISN (checking that they are
>    part of MAC generation)
> 3. check restore with wrong SEQ number extension (checking that
>    high bytes of it taken into MAC generation)
> 
> Sample output expected:
> > # ./restore_ipv4
> > 1..20
> > # 1412[lib/setup.c:254] rand seed 1686610825
> > TAP version 13
> > ok 1 TCP-AO migrate to another socket: server alive
> > ok 2 TCP-AO migrate to another socket: post-migrate connection is alive
> > ok 3 TCP-AO migrate to another socket: counter TCPAOGood increased 23 => 44
> > ok 4 TCP-AO migrate to another socket: counter TCPAOGood increased 22 => 42
> > ok 5 TCP-AO with wrong send ISN: server couldn't serve
> > ok 6 TCP-AO with wrong send ISN: post-migrate connection is broken
> > ok 7 TCP-AO with wrong send ISN: counter TCPAOBad increased 0 => 4
> > ok 8 TCP-AO with wrong send ISN: counter TCPAOBad increased 0 => 3
> > ok 9 TCP-AO with wrong receive ISN: server couldn't serve
> > ok 10 TCP-AO with wrong receive ISN: post-migrate connection is broken
> > ok 11 TCP-AO with wrong receive ISN: counter TCPAOBad increased 4 => 8
> > ok 12 TCP-AO with wrong receive ISN: counter TCPAOBad increased 5 => 10
> > ok 13 TCP-AO with wrong send SEQ ext number: server couldn't serve
> > ok 14 TCP-AO with wrong send SEQ ext number: post-migrate connection is broken
> > ok 15 TCP-AO with wrong send SEQ ext number: counter TCPAOBad increased 9 => 10
> > ok 16 TCP-AO with wrong send SEQ ext number: counter TCPAOBad increased 11 => 19
> > ok 17 TCP-AO with wrong receive SEQ ext number: post-migrate connection is broken
> > ok 18 TCP-AO with wrong receive SEQ ext number: server couldn't serve
> > ok 19 TCP-AO with wrong receive SEQ ext number: counter TCPAOBad increased 10 => 18
> > ok 20 TCP-AO with wrong receive SEQ ext number: counter TCPAOBad increased 20 => 23
> > # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

