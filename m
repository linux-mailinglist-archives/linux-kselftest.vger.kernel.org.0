Return-Path: <linux-kselftest+bounces-3105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF482F5F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954531F23694
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB6224D1;
	Tue, 16 Jan 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oopk+Fl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700A22314
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434201; cv=none; b=eFyh9ppw99rjLylzCMNZKVb50iHOJARqK8qkgJyjXxftQrhSlHS9cmWNgCdYEjhzc68y+eIjGlkkD4NWn/VlZg+Nm6WTuDrbMB9DyH7bkxMQQ1aJdq2dyRz/g/gJj0uZddycNfl3BBEDySba+XYfeGIQmNc7lGuIqbChi/eJ2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434201; c=relaxed/simple;
	bh=ylXaHvN4FsZJ4dreRqWu7RlLlrpDoxM0H9BJGvVATMA=;
	h=Received:DKIM-Signature:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:
	 References:Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID; b=UhS5JvknD+ADk7y26IMp1+1ANbVvZkh9hJjex7orChTBLu1DprBueeZRRo2TZebWCL2yhQF+C3lzBzigZlA85bH+/ZXpER0FXil2h48CTr7piFLdlZRTMImkDI2r6SGAN1Ynl45XqB19BbvS+fmOa6N3RV0+trMIIhIlArUsvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oopk+Fl3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E29BA3F275
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705434191;
	bh=JuJRvvB1+ydFjfdWkwULbdquMIAL4NmSy2J+3MJ9Fds=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=oopk+Fl3biiAruxqeGR4sbibgd5babSrszHDzIzt8T0tm9WW980H+I3u2nNEEVVyt
	 La/FuS32eSfF66C496mqRfAq8PTJz6apCxsS+LYH7ijavQT5y+R7klV9y64iLYcyt3
	 e18F4FU/HKPSbzgMnyaKIi9YSJWY0Adff8ZqJQ5AN+Lo9fF1WNiA+qjyCvPqFmBBoD
	 jM2q0OcKtrQObEe9Ex3WUyrepAyudxVlNy52XS830089iO7f/tYUkqAa/p/Ejh4GkF
	 sNvEyy5ituE3iqMoSb48RGrL9XnXgWyjmFsVEDFq6Cuj5bx3Rin9dL24oC34F4S+X3
	 CxoFt8GcqIs7w==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4a097002fso107687285ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 11:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705434190; x=1706038990;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuJRvvB1+ydFjfdWkwULbdquMIAL4NmSy2J+3MJ9Fds=;
        b=pScMY9CTFQFp9cEqUBXqeOpFXYlwjdUIIfEp1FAwWaKcArmuwHXjP9QNFe9WVrxLCJ
         D0tricPeZ7va2SM6BFvCrcpkoz0ElAYzXDZ0+nvYPNefUNhNn+0mbW4fwta4ECs8N5L7
         p91upeX07TTdcu1V5oDsUQgfTVPv+5SqHmP7HKi5JwdyryBwa0PB8hRK5eRAvbkoEmqB
         vPTxR74k3Bix/cOgPB3qqe3bsFd8jEJ/4Qdks2utNzhQNiZaOcjY48QsPTkMZELuoVoD
         uLr7LMGds0afR/KU9H7LA6JWmXz8AkS/sjHck5+HFiN2qk3+W6vE/0R+E5YndNhea4ea
         khkQ==
X-Gm-Message-State: AOJu0Yw4fibWF8vPS9qmzAkYV3VeNpmm3wkKlbSCWn+JL/JiL4UFnJDd
	rkGYzarc5Rswo06O4osewZnygVz/bXqgz1LQhyhLAx0tdvo9qrWxM52oWz1WK60lI8LySCyYed2
	5WqMCqEpwNl0OgdQWt9L9YFbDwtXqPmyS1qy+zRDSmJ09uKNUqcnjrEoi/wlQ
X-Received: by 2002:a17:902:a38c:b0:1d3:5ed5:764a with SMTP id x12-20020a170902a38c00b001d35ed5764amr8626601pla.123.1705434190350;
        Tue, 16 Jan 2024 11:43:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmZOv1iUaWs4nVED3mP0z7VQpUbtbMUwjRQ1gBwOoo3WCGpNaoC24UTTgJZ0kGqT0kQtNqHA==
X-Received: by 2002:a17:902:a38c:b0:1d3:5ed5:764a with SMTP id x12-20020a170902a38c00b001d35ed5764amr8626585pla.123.1705434190074;
        Tue, 16 Jan 2024 11:43:10 -0800 (PST)
Received: from vermin.localdomain ([209.121.128.189])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709028c8200b001d5d58216bdsm3017424plo.164.2024.01.16.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:43:09 -0800 (PST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 21BB11C3BC4; Tue, 16 Jan 2024 11:43:09 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 200D51C3BC3;
	Tue, 16 Jan 2024 11:43:09 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Benjamin Poirier <bpoirier@nvidia.com>,
    Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
    Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Jonathan Toppins <jon.toppins+linux@gmail.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Michal Kubiak <michal.kubiak@intel.com>,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
In-reply-to: <20240116112926.541e0651@kernel.org>
References: <20240116154926.202164-1-bpoirier@nvidia.com> <20240116104402.1203850a@kernel.org> <78106.1705431810@vermin> <20240116112012.026e44d9@kernel.org> <ZabXT2ZepMuinE50@d3> <20240116112926.541e0651@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Tue, 16 Jan 2024 11:29:26 -0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78765.1705434189.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 11:43:09 -0800
Message-ID: <78766.1705434189@vermin>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Tue, 16 Jan 2024 14:21:51 -0500 Benjamin Poirier wrote:
>> real    13m35.065s
>> user    0m1.657s
>> sys     0m27.918s
>> =

>> The test is not cpu bound; as Jay pointed out, it spends most of its
>> time sleeping.
>
>Ugh, so it does multiple iterations of 118 sec?
>
>Could you send a patch to bump the timeout to 900 or 1200 in this case?

	We could also lower the interval or number of notifications;
right now "peer_notif_delay 1000" puts 1 second between the ARPs in the
num_grat_arp() test.  I'm not sure why that value was chosen, but the
peer_notify_delay is rounded to units of the miimon interval, and in
this test miimon is 100 msec.

	I haven't tested this at all, but something like

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b=
/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index c54d1697f439..95eb77aebc3c 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -277,7 +277,7 @@ garp_test()
 	ip -n ${s_ns} link set ${active_slave} down
 =

 	exp_num=3D$(echo "${param}" | cut -f6 -d ' ')
-	sleep $((exp_num + 2))
+	sleep $((exp_num / 5 + 2))
 =

 	active_slave=3D$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linki=
nfo.info_data.active_slave")
 =

@@ -297,7 +297,7 @@ num_grat_arp()
 {
 	local val
 	for val in 10 20 30 50; do
-		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_=
delay 1000"
+		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_=
delay 200"
 		log_test "num_grat_arp" "active-backup miimon num_grat_arp $val"
 	done
 }

	could substantially reduce the time to run the test.  It's kind
of icky with magic numbers, but that could be cleaned up.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

