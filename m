Return-Path: <linux-kselftest+bounces-2136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC981697C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 10:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86615281188
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF011C91;
	Mon, 18 Dec 2023 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHnNrR6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4D14F7D;
	Mon, 18 Dec 2023 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9d8bfe845so2359380b6e.0;
        Mon, 18 Dec 2023 01:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702890671; x=1703495471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNeKrvGUP+WlwkH5sDzyqCtLnYvJl97jtOJjTE/P92o=;
        b=YHnNrR6TCBC17Z5vcpRMp9sH2L/12GK1kL6sSKUcyh9ah2lZiet4F2Ok3TUaIHAEEd
         cEAwBlbAU+Ky+AG5htIjCaToizP5FoSyNTuovRxH7po4CiO8PVM62OWZV34Y78iU3UDM
         QHsVnUzjZSev4ZNwEn0nfrvD1T107h3ox0UrjNOofES+9MoTUbwkVXA5lKOp875ruH1z
         qhg4dboRHOa0xDaqY1Fis6ju/ZBQgVtXvgHPtWWJ/Yq4TDLi8zC99T95SlAu0RuhtUDm
         h9vm5rArJ2okcsl8c/njdDYS0NAns+zufV6Tc3/RLbw+IPDiDDEynPNKz73kobw5zQwd
         KAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890671; x=1703495471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNeKrvGUP+WlwkH5sDzyqCtLnYvJl97jtOJjTE/P92o=;
        b=dFRBO1npkkSGte519xr7wBr3hrXtiVbV2SNziQ4If57TmOvD70vOswIHXP7WqjQXjB
         jildazahI2ECJFSD6Evjr2pyGbKjlJU+01/IG1bhpibVRwoG20Z5ShU/RTuDKhy+coc+
         FIqgYNQqz6d3AWzb7r/Y1XomixcjtqBjG371SKajZDz8UKH7kLbrClH6lFa5BAA+MlgL
         gtuXafv95TvxommHZZzAIehBXTIGbgv9SwjG0pdrPxqq6CF5eUmWenry+d9N30wQmPw5
         wvObRXVutwL0h1V9nDqbBqeYx050yF1nCPttd445iCPYHQMchoKKWVbI5g8Jo/4lV6hQ
         nHkA==
X-Gm-Message-State: AOJu0YzSikiyW2Jr+m3KmBIPdClEZhV6IywBtu94AhZNwAReZh9/M/f7
	oFBNGpDMqqqyCQXQJQlZMfU=
X-Google-Smtp-Source: AGHT+IGQqEloJ0c93wdozKFLb9k6jDS/s2mykJx8uH5mMyNbMPcInXdauiSlSJmpDPBFLFUHF94gDA==
X-Received: by 2002:a05:6808:2e46:b0:3b9:f02e:6792 with SMTP id gp6-20020a0568082e4600b003b9f02e6792mr22984783oib.115.1702890670823;
        Mon, 18 Dec 2023 01:11:10 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kr5-20020a056a004b4500b006ce83da3076sm18130808pfb.170.2023.12.18.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:11:10 -0800 (PST)
Date: Mon, 18 Dec 2023 17:11:05 +0800
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
Subject: Re: [PATCH 09/12] selftests/net: Add SEQ number extension test
Message-ID: <ZYAMqQSOM6kx_Kh9@Laptop-X1>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-9-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-tcp-ao-selftests-v1-9-f6c08180b985@arista.com>

On Fri, Dec 15, 2023 at 02:36:23AM +0000, Dmitry Safonov wrote:
> Check that on SEQ number wraparound there is no disruption or TCPAOBad
> segments produced.
> 
> Sample of expected output:
> > # ./seq-ext_ipv4
> > 1..7
> > # 1436[lib/setup.c:254] rand seed 1686611079
> > TAP version 13
> > ok 1 server alive
> > ok 2 post-migrate connection alive
> > ok 3 TCPAOGood counter increased 1002 => 3002
> > ok 4 TCPAOGood counter increased 1003 => 3003
> > ok 5 TCPAOBad counter didn't increase
> > ok 6 TCPAOBad counter didn't increase
> > ok 7 SEQ extension incremented: 1/1999, 1/998999
> > # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

