Return-Path: <linux-kselftest+bounces-2129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E781691D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A48282088
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC3310A10;
	Mon, 18 Dec 2023 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZx0lTU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D1118B;
	Mon, 18 Dec 2023 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28ade227850so2224160a91.2;
        Mon, 18 Dec 2023 01:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890207; x=1703495007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak/uY7ctjUJpG2EB2nkOjy7ocgBtOBfLnLR5sFh/TJA=;
        b=UZx0lTU6r0W3/ufBdYUXIHGdWXJEh/NkCb9gPxwZLOLh8Gv7TCz0qmg5DqNm9zxOep
         s3yBmKET0O8yelwNkRH6N9ZwVt94Ks7fW6ra/9wRgT7FaQyXcreI1W3KahS6hzKGeHfh
         RSA4SoW4G4qdlqipNzgroxgY1iKiuJm7MXyy773HIfgt0dQoEQ6KTrWjPHYUKcaj0Mg2
         DXyoTE03N61j4Phli2mG14GGLPtDSJdgnssYDAq2LPFBa+U4Vh7xs725bp4qmegkB/Td
         YMuwmnaIaJkdKqOiaqFwmD464Wep5F92k4XQTfEhjUWpRCltZiSptrihB11NR85Rkd7b
         kSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890207; x=1703495007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak/uY7ctjUJpG2EB2nkOjy7ocgBtOBfLnLR5sFh/TJA=;
        b=UXzHq+cqRz//A6xQBgpPLF8pG5DIgN3p9bgkv/8U7iUu7MtdJMb1b861kxCXSxvfTv
         tkgw5CtyOZHYW3rzKBEUar+mOtxKlotI7nob7TZx7QxffY66amUaLFS/3IMIYczrkWye
         gIUOlQRRzAL+FwuKqpD4Ny7/1MVULtBHJrAwxEEIQHsX71K1zEn2XOqc9kuVzFRkJ7uA
         oM+gvB9dF8fEFDDuVEwnjcp7UFAtecedxoES6J5soPEwEPdvrViStT/UeA3XFLi7ER7/
         ZTamsinjxmovpK71SpMsJemyakqmpYZVSatq9NIGNPtCnOCalwGzR7tqz5hNKqXgNH2B
         BUHA==
X-Gm-Message-State: AOJu0Yx3Fd2LxiBNWVRCLPWmBJegrpajeTE2+7vwexfmd2m7mu+0SW1v
	E4M1n7pbNIDecYUxxRHjC3Y=
X-Google-Smtp-Source: AGHT+IFSKH+fRCqgmyE2xogsVWKfTvVyijpoHCjNrGMowybsup8w1lOtkHbMsO62D3YfJrmRDEKNIA==
X-Received: by 2002:a17:90b:1d8b:b0:28b:5a99:c02e with SMTP id pf11-20020a17090b1d8b00b0028b5a99c02emr931913pjb.83.1702890207418;
        Mon, 18 Dec 2023 01:03:27 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id si6-20020a17090b528600b0028aefb5fa05sm3892619pjb.40.2023.12.18.01.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:03:26 -0800 (PST)
Date: Mon, 18 Dec 2023 17:03:21 +0800
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
Subject: Re: [PATCH 02/12] selftests/net: Verify that TCP-AO complies with
 ignoring ICMPs
Message-ID: <ZYAK2U4GikRKFLQs@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-2-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-2-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:16AM +0000, Dmitry Safonov wrote:
> Hand-crafted ICMP packets are sent to the server, the server checks for
> hard/soft errors and fails if any.
> 
> Expected output for ipv4 version:
> > # ./icmps-discard_ipv4
> > 1..3
> > # 3164[lib/setup.c:166] rand seed 1642623745
> > TAP version 13
> > # 3164[lib/proc.c:207]    Snmp6             Ip6InReceives: 0 => 1
> > # 3164[lib/proc.c:207]    Snmp6             Ip6InNoRoutes: 0 => 1
> > # 3164[lib/proc.c:207]    Snmp6               Ip6InOctets: 0 => 76
> > # 3164[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 0 => 1
> > # 3164[lib/proc.c:207]      Tcp                    InSegs: 2 => 203
> > # 3164[lib/proc.c:207]      Tcp                   OutSegs: 1 => 202
> > # 3164[lib/proc.c:207]  IcmpMsg                   InType3: 0 => 543
> > # 3164[lib/proc.c:207]     Icmp                    InMsgs: 0 => 543
> > # 3164[lib/proc.c:207]     Icmp            InDestUnreachs: 0 => 543
> > # 3164[lib/proc.c:207]       Ip                InReceives: 2 => 746
> > # 3164[lib/proc.c:207]       Ip                InDelivers: 2 => 746
> > # 3164[lib/proc.c:207]       Ip               OutRequests: 1 => 202
> > # 3164[lib/proc.c:207]    IpExt                  InOctets: 132 => 61684
> > # 3164[lib/proc.c:207]    IpExt                 OutOctets: 68 => 31324
> > # 3164[lib/proc.c:207]    IpExt               InNoECTPkts: 2 => 744
> > # 3164[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> > # 3164[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 200
> > # 3164[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 199
> > # 3164[lib/proc.c:207]   TcpExt                 TCPAOGood: 2 => 203
> > # 3164[lib/proc.c:207]   TcpExt         TCPAODroppedIcmps: 0 => 541
> > ok 1 InDestUnreachs delivered 543
> > ok 2 Server survived 20000 bytes of traffic
> > ok 3 ICMPs ignored 541
> > # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Expected output for ipv6 version:
> > # ./icmps-discard_ipv6
> > 1..3
> > # 3186[lib/setup.c:166] rand seed 1642623803
> > TAP version 13
> > # 3186[lib/proc.c:207]    Snmp6             Ip6InReceives: 4 => 568
> > # 3186[lib/proc.c:207]    Snmp6             Ip6InDelivers: 3 => 564
> > # 3186[lib/proc.c:207]    Snmp6            Ip6OutRequests: 2 => 204
> > # 3186[lib/proc.c:207]    Snmp6            Ip6InMcastPkts: 1 => 4
> > # 3186[lib/proc.c:207]    Snmp6           Ip6OutMcastPkts: 0 => 1
> > # 3186[lib/proc.c:207]    Snmp6               Ip6InOctets: 320 => 70420
> > # 3186[lib/proc.c:207]    Snmp6              Ip6OutOctets: 160 => 35512
> > # 3186[lib/proc.c:207]    Snmp6          Ip6InMcastOctets: 72 => 336
> > # 3186[lib/proc.c:207]    Snmp6         Ip6OutMcastOctets: 0 => 76
> > # 3186[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 4 => 568
> > # 3186[lib/proc.c:207]    Snmp6               Icmp6InMsgs: 1 => 361
> > # 3186[lib/proc.c:207]    Snmp6              Icmp6OutMsgs: 1 => 2
> > # 3186[lib/proc.c:207]    Snmp6       Icmp6InDestUnreachs: 0 => 360
> > # 3186[lib/proc.c:207]    Snmp6      Icmp6OutMLDv2Reports: 0 => 1
> > # 3186[lib/proc.c:207]    Snmp6              Icmp6InType1: 0 => 360
> > # 3186[lib/proc.c:207]    Snmp6           Icmp6OutType143: 0 => 1
> > # 3186[lib/proc.c:207]      Tcp                    InSegs: 2 => 203
> > # 3186[lib/proc.c:207]      Tcp                   OutSegs: 1 => 202
> > # 3186[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> > # 3186[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 200
> > # 3186[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 199
> > # 3186[lib/proc.c:207]   TcpExt                 TCPAOGood: 2 => 203
> > # 3186[lib/proc.c:207]   TcpExt         TCPAODroppedIcmps: 0 => 360
> > ok 1 Icmp6InDestUnreachs delivered 360
> > ok 2 Server survived 20000 bytes of traffic
> > ok 3 ICMPs ignored 360
> > # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

