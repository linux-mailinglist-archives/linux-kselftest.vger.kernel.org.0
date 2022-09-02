Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F09A5AB825
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIBS2r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIBS2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 14:28:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23651114C2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 11:28:44 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E2513F5F1
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662143323;
        bh=N+q9bzVmloLRe9hcZwddZqyizZWp6VIca78c9sJNXcM=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=m2J7rTZw5knjW7J8JAacKpvdnbehu5kgJu60o5/+4UUFsYGS1zPiZfawnrlRmKLCp
         611gNe5pm5jtet3yGCU9LdsUmZYk/vXGPotSAmQ9S62F/lrER1v2EOHkBjctt1wR4+
         1mxpJgqZMOOTKplxuf4Fmxr5rN171kw8AyHLAQgqurQV+FBMD0qLUBZX51Umzk6e3q
         PwEO6N5ZuJ5VUvXfrXkJ4PmOb6Wi2qo+S84bKPlaj4ClxOVmQkxcEH7Vn+m/Kugk1N
         DfrQepDs4OBsfTC6awApB6d+D0EeX9xI5FDiYBIMb4jQGOH+6dQ7CMP7VlB3YXj4V7
         wg6xA647iSEnA==
Received: by mail-pj1-f72.google.com with SMTP id e1-20020a17090a7c4100b001fd7e8c4eb1so1491910pjl.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 11:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N+q9bzVmloLRe9hcZwddZqyizZWp6VIca78c9sJNXcM=;
        b=RPuPE5EM/2u+KlZWl1iJw9tQXrlki8D/zf8WPEParDpGXQAtIgBgeHU7J2LfCcc/IE
         /3MnLnaAzWvO+OGEl1vnwUREobvD40MB9QJLTYczvICUlOnMaL63uVsojJPqhxMi0l+s
         vJ7gMdRVeYivCVmysBc0NrzuV2IVzGEKmCEN0u0d/hy5DmtGjyY429H2grgRmR3n9lQt
         v8QdwU3tSvB4ttDKRghb2oOUEvEbUSy73dzihGd5nDLES156WyX8sev0X6YwfGlGbKoS
         kVy/eUGyHHtQhTopp+ClOjxfAXSQk8njhUGUkELjkCdmUE3Pf+KbzOXFXx6QORAJ7hX4
         fkJA==
X-Gm-Message-State: ACgBeo1ehQ5jiuyxKmxy4abeAgm/jjsG5YFUaQyErYh3JAq/6pbgKgpa
        XAvVvIuweq/g7+1FDlAMRISGn5SAUallOmMed6rFceWbjNTDAxxn3KHAAd6gTgn6nxBDRNTK7Nb
        NAFQA1S6VWMywMkapwWsaDt/aU7lPxtEaQ/lbAatN+yZrgw==
X-Received: by 2002:a17:90b:3e8b:b0:1f5:2a52:9148 with SMTP id rj11-20020a17090b3e8b00b001f52a529148mr6015020pjb.175.1662143321639;
        Fri, 02 Sep 2022 11:28:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4BWhLQclxdOb2A06vgLmat1p4eP3ZZMSFECphj7m3+9ZJGkncrshLod4ZvYpdkk2LxvkwVqg==
X-Received: by 2002:a17:90b:3e8b:b0:1f5:2a52:9148 with SMTP id rj11-20020a17090b3e8b00b001f52a529148mr6014993pjb.175.1662143321347;
        Fri, 02 Sep 2022 11:28:41 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a2f8200b001fabcd994c1sm5526147pjd.9.2022.09.02.11.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2022 11:28:40 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 70679604E3; Fri,  2 Sep 2022 11:28:40 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 69A1DA02D5;
        Fri,  2 Sep 2022 11:28:40 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Benjamin Poirier <bpoirier@nvidia.com>
cc:     netdev@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Toppins <jtoppins@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: bonding: Unsync device addresses on ndo_stop
In-reply-to: <20220902014516.184930-2-bpoirier@nvidia.com>
References: <20220902014516.184930-1-bpoirier@nvidia.com> <20220902014516.184930-2-bpoirier@nvidia.com>
Comments: In-reply-to Benjamin Poirier <bpoirier@nvidia.com>
   message dated "Fri, 02 Sep 2022 10:45:14 +0900."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27921.1662143320.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 02 Sep 2022 11:28:40 -0700
Message-ID: <27922.1662143320@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benjamin Poirier <bpoirier@nvidia.com> wrote:

	Repeating a couple of questions that I suspect were missed the
first time around:

>Netdev drivers are expected to call dev_{uc,mc}_sync() in their
>ndo_set_rx_mode method and dev_{uc,mc}_unsync() in their ndo_stop method.
>This is mentioned in the kerneldoc for those dev_* functions.
>
>The bonding driver calls dev_{uc,mc}_unsync() during ndo_uninit instead o=
f
>ndo_stop. This is ineffective because address lists (dev->{uc,mc}) have
>already been emptied in unregister_netdevice_many() before ndo_uninit is
>called. This mistake can result in addresses being leftover on former bon=
d
>slaves after a bond has been deleted; see test_LAG_cleanup() in the last
>patch in this series.
>
>Add unsync calls, via bond_hw_addr_flush(), at their expected location,
>bond_close().
>Add dev_mc_add() call to bond_open() to match the above change.
>The existing call __bond_release_one->bond_hw_addr_flush is left in place
>because there are other call chains that lead to __bond_release_one(), no=
t
>just ndo_uninit.
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
>---
> drivers/net/bonding/bond_main.c | 31 +++++++++++++++++++++----------
> 1 file changed, 21 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 2f4da2c13c0a..5784fbe03552 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -254,6 +254,8 @@ static const struct flow_dissector_key flow_keys_bond=
ing_keys[] =3D {
> =

> static struct flow_dissector flow_keys_bonding __read_mostly;
> =

>+static const u8 lacpdu_multicast[] =3D MULTICAST_LACPDU_ADDR;
>+
> /*-------------------------- Forward declarations ----------------------=
-----*/
> =

> static int bond_init(struct net_device *bond_dev);
>@@ -865,12 +867,8 @@ static void bond_hw_addr_flush(struct net_device *bo=
nd_dev,
> 	dev_uc_unsync(slave_dev, bond_dev);
> 	dev_mc_unsync(slave_dev, bond_dev);
> =

>-	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>-		/* del lacpdu mc addr from mc list */
>-		u8 lacpdu_multicast[ETH_ALEN] =3D MULTICAST_LACPDU_ADDR;
>-
>+	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
> 		dev_mc_del(slave_dev, lacpdu_multicast);
>-	}
> }
> =

> /*--------------------------- Active slave change ----------------------=
-----*/
>@@ -2171,12 +2169,8 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
> 		dev_uc_sync_multiple(slave_dev, bond_dev);
> 		netif_addr_unlock_bh(bond_dev);
> =

>-		if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>-			/* add lacpdu mc addr to mc list */
>-			u8 lacpdu_multicast[ETH_ALEN] =3D MULTICAST_LACPDU_ADDR;
>-
>+		if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
> 			dev_mc_add(slave_dev, lacpdu_multicast);
>-		}
> 	}

	Just to make sure I'm clear (not missing something in the
churn), the above changes regarding lacpdu_multicast have no functional
impact, correct?  They appear to move lacpdu_multicast to global scope
for use in the change just below.

> 	bond->slave_cnt++;
>@@ -4211,6 +4205,9 @@ static int bond_open(struct net_device *bond_dev)
> 		/* register to receive LACPDUs */
> 		bond->recv_probe =3D bond_3ad_lacpdu_recv;
> 		bond_3ad_initiate_agg_selection(bond, 1);
>+
>+		bond_for_each_slave(bond, slave, iter)
>+			dev_mc_add(slave->dev, lacpdu_multicast);
> 	}

	After this change, am I understanding correctly that both
bond_enslave() and bond_open() will call dev_mc_add() for
lacpdu_multicast?  Since dev_mc_add() -> __dev_mc_add() calls
__hw_addr_add_ex() with sync=3Dfalse and exclusive=3Dfalse, could that all=
ow
us to end up with two references for lacpdu_multicast?

	-J

> =

> 	if (bond_mode_can_use_xmit_hash(bond))
>@@ -4222,6 +4219,7 @@ static int bond_open(struct net_device *bond_dev)
> static int bond_close(struct net_device *bond_dev)
> {
> 	struct bonding *bond =3D netdev_priv(bond_dev);
>+	struct slave *slave;
> =

> 	bond_work_cancel_all(bond);
> 	bond->send_peer_notif =3D 0;
>@@ -4229,6 +4227,19 @@ static int bond_close(struct net_device *bond_dev)
> 		bond_alb_deinitialize(bond);
> 	bond->recv_probe =3D NULL;
> =

>+	if (bond_uses_primary(bond)) {
>+		rcu_read_lock();
>+		slave =3D rcu_dereference(bond->curr_active_slave);
>+		if (slave)
>+			bond_hw_addr_flush(bond_dev, slave->dev);
>+		rcu_read_unlock();
>+	} else {
>+		struct list_head *iter;
>+
>+		bond_for_each_slave(bond, slave, iter)
>+			bond_hw_addr_flush(bond_dev, slave->dev);
>+	}
>+
> 	return 0;
> }
> =

>-- =

>2.37.2
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
