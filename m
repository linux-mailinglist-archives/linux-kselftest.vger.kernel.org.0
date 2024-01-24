Return-Path: <linux-kselftest+bounces-3463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517283AF18
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DA81F22164
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439377E798;
	Wed, 24 Jan 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gg6UX320"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D17E792;
	Wed, 24 Jan 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115838; cv=fail; b=Qd5q+S4BSDKrvqsI1TSm1RHZJhXnM4cBrm9wU7AJIwnPttRe3RXIV3ubm2ZJ+jw3jvbkfLjlO314DMfulML/eOz4loF7ERKNP7Sfle85pRcOAFerXZJMuPRiPdkmAm/EFP3K/xyAREWowY4ASQ0qsP5GtFsbwc2kjbaxxXPfuWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115838; c=relaxed/simple;
	bh=sDgsJ3ZKek+eX++6tYJcN3FQ9OBLNR5xGs9UeeReMN4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=odIJ0JHTdOojL5cXAeV9JhW3AkD42U6WJpxVDcGHECgb9Dgt/7p3iW3EVmif1fj4apOtzBEZIN0+ZyqXSiqiOwM0oQMRVWbZ+iDqEVkqCfHyLbGPccZIcr1prPmDVsARxCb5YjQXwoGPrhq/sw+6PV4OtzDLQ7ObZwWw38z7ZKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gg6UX320; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GII4LL2j+6pOu21Fz66i7DLBoMuM/01rXB6iTWz0f+yrZMDVc7dUYayZjFiH+zhruPgFs7kmp3mpRfCkvPu8uxzaYF/qCxf1zen9aKA+dssVKc5w8iPBalOwV7jj5dG5Ts+OY+mN0w4Bt+cCvGZhVke4Cob2GWilmlOREV6B9wOrrA6+dBNp3Jm788uU+8/OvpfBQuMOXMBkQZwhzXNObZtMiyUzvxw3Vhy46bUX4CAtKbG20DDmxqO4fiH16I5ieqvdb4sVQw/VRKxohUUZJzlDoZtCZExVwEiy0GrqEgakJ7h0MLk+QYG94D3fX7TugjSw8TpeymFka1MNc8rRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzojBnrH+/7YTpILKzLjmwM+cJrNjUFWQMhB7vmeuKc=;
 b=hfQo7dCZdYTjTN5fm68sFb5s7e6IPDHBANSQ70nwvv6O06NDEtmEWsZEQtE3bK9DyE+vGf1MAx7P0iLLupUQKGZnPP6oxdXVGKfJhjYmEr0aRe/VaSE5+n+E067qwVO5PJ+/i2Xjuf/Y62HBXaifhv3XW38BAelZnML2ke2eN9dCV2k7dp1Ti6lCya+zo2M/L8Uf9AIpd2bzonFSlJQYp3mnioQkwvuN0bhZJTnnfB7IkrAY34XCQub7CKSmzcBRDYNX9uhhVVAnBqpw4uGaRb+TM4WKq4YLcqxsZ4dI0eQtIdS+i6sZ7uMZIHx3eyXvVEqgywiEDIcUI2gij+TLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzojBnrH+/7YTpILKzLjmwM+cJrNjUFWQMhB7vmeuKc=;
 b=gg6UX320ms+TMTCbZCk1IcT+VyTy0ZsWhZV7BoZZv5NUtkqxNtRijGjC802qLZexeyzBtuIpoiHriPsP/hGyRkGwJJxewnRpLrak5BMCy/IlxeGwwmGPL281PCi3ymVuzBqkakTg6i8Fv+cpEE1lS5M3ZPbn6ooAzsyfdSBystrUFuIZmVdQw/puaP4XbMr8ACcVjuO50zwYUQpXkq5eSSthq0lpvYfSLKVyDjIgkH1XanoLkqLZhYTIKNsBNX7PYbJS9ElIizFwWUvQAvSdwJSi9l7esXgn/HYg2pDzhp5Psgf4zXdIPxO9vV3Np7O0w5eZQKxzdiOCaoFCEFPc/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:43 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:43 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 0/6] selftests: Add TEST_INCLUDES directive and adjust tests to use it
Date: Wed, 24 Jan 2024 12:02:16 -0500
Message-ID: <20240124170222.261664-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::30) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: c593ed68-01ec-4ce7-0ae7-08dc1cfe47d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q1Q9jMGvf6d3NH7+LdAKOslCU7CwBZ3W6aRnGLxHhOtZLL9/oURO1uRTQb9KMtzNHdT/FDW2Zz79wmUmmRsO8SEeKJh9k8mMqiY+Y1W6XaFs1z/c5GK02sfmLWvZhdVGeT/0ZYFTICmqSHICuUik/bpBTahtlo8/R8dxcxEvXf+KLbUI6E5rFYjxfxdwxEeamqHsiFt7+cYjJo8QSF/UGwkRpn6vJp/wq7leenH8Db7ZQ3c1xdpI7Xuku8iT6HvE7cwSd5s6ZyLs7H6qCC6iNiAOHRkJnMTVXDjjdKUQRl1h3AcQAGUpwQNq92Gw2NqC7oHnqw958upGkM7zxtpkZkeBzxK+spxEK9rVbYUUrxKVqLBgbTMNTgUD+/jC/+mR/9IXJEMdHLXZ/WK033j/gR/1eLCqt8ctn3hGl1SoX9E1aKl0BUT5Q4hsoPy5PX/6TFfAcGtOzyzTd82Dx/lC7G0LR3+bEtEWtAP/kfSFdfh325qr39YHjZUAWFyBuENTimU/xRZSqDqceG0PqrYpusfXwDUrruILRtzP4GF6BjtTgrKTJYD2Wixqd6aBQvWGjn9+gcBFdTmw/69tYpZa4X1UmsdS5XlXTnxo0F+GpDcUUdNw7u+QobmifUacDHu78YrkQbN7EnAEBIjQAvrNTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(966005)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpbvpSqunK5ud7rkPHk7d02RQVly+188snaO7GHXxKNRc+FmQqkvX5jyvtLD?=
 =?us-ascii?Q?vej3wLWOu79CHYNRWRFs7iaiGrzZN5FqwRGvkR0AZ0RY6wQAQlf5ueS96e0V?=
 =?us-ascii?Q?LlxgMf/c5ya4En9F/5UoWMpxjLgqGNccyq9C3i/8Qb9qD4dvEmY6DKpZSjjW?=
 =?us-ascii?Q?MemJtGdyAYYPLjWjG13rml6oVxfCjAky3M5/2ZJT/gurbqU2OYMYJ9DrXylB?=
 =?us-ascii?Q?dCLXwlEAfS3ZFysy+fTizqp46m1a8Br1I2Y1m49d7TZL8O3iSGNEuQ/gWJfo?=
 =?us-ascii?Q?r1xdnC9R2jCyapk/SeMTqfIVJ3t9/zg5rKyBRLkY0v36JY3ZSNTx4kZN/SVg?=
 =?us-ascii?Q?1CPZ+D+xRF1hVHz0RbhgnDcoNYiGuCxPhSgBOtazpQ6M2vHYpWXz7Eyy3B26?=
 =?us-ascii?Q?FXya5yg+EFBZF61TDk8hNv2PxB09sk+j18ScWPmIdAWPcrsg9Z/U9O253wRt?=
 =?us-ascii?Q?CEBczAEMQ6/UMeZYJaw5UOOurg7S894H76Khrv1OISFGvOWFylqml43VF3AU?=
 =?us-ascii?Q?0vzqUn6lSPT5ylja0mvM9++CFdb9znL0neQdrffSQk9xz7slb0mVDO9RoCuS?=
 =?us-ascii?Q?TM0UGiqO/uM8bsAWSPML154qrV+FM9kbgRlIkiJTi/zLKXH147WkpOqNHnGZ?=
 =?us-ascii?Q?+Qi69g61jgjMA9NX9mtBV9p/hb8Lf3RDPA9IaSCtSs9yoVAhhWodm5BJfQaN?=
 =?us-ascii?Q?5XssxscWa1xArf3ayehGeFc11uFwRYtOVVIlyLcASt9XlHWyyvlxMMrq/0dU?=
 =?us-ascii?Q?AWvYA17UpkSkZFQJlAGQQnonfuODgcJgBK4tbkrutS+yKsd+agEhDwaYfeRO?=
 =?us-ascii?Q?OxDktRGnmrIWwfVG3EBdFLi41YIUlA+ltv+mhXIqkuGY3pazPrqBRwqDIQFI?=
 =?us-ascii?Q?3i+pllypk4ldIY34clIL/Xod09ktPF7ARvcY+3VJ2pxiBPn4+zTudqvhiXGe?=
 =?us-ascii?Q?gnCI6kRrB5JyWzLCRQvSB7I6h28UPFAYqWcgDkwDs7HOrugJXtdwiLFL/03u?=
 =?us-ascii?Q?FIQVcMx9Er5rs0M2Bz01UYzswHSaUZKpI72cwnqUbZvyRe7oTaMu/jyBwU9M?=
 =?us-ascii?Q?Nz+0z/u5O3RgYKeIzjSk5zh67JXoAg4hvhyIXv8GMgQaAQseWvByo50uWjBY?=
 =?us-ascii?Q?HfE2k1vsI5Y4/NRPjG1An7F1wfwQmcJtX/53rfi0n8iHixjkXFwB0XFrfmrG?=
 =?us-ascii?Q?h7ULgjevKFgpDKTxZHoqk0u1LfPBMeB9yPhArkC+pIOXc80og8xdqK1oirij?=
 =?us-ascii?Q?AGgE6HoYEfVjz9IIlbKxJgviyYVQqBy8vNCSce3uhUovoxLzAk5eczUwxtJf?=
 =?us-ascii?Q?j27mlfkyP9U29QH3mL45XmEHLM1uUcuFseLwdpIG9kTCAbEwZU0aSJ2tWLpK?=
 =?us-ascii?Q?lfGE2c89j0DE9FntqLildnnwLPmnrkEkMfQKakNLXzclek2ams5jacEyEU84?=
 =?us-ascii?Q?iVdkNdNOxuKhseS4PBkE1m49AoC9AepgnwMq0O1HYNlFMH2fowJhidFMI+xG?=
 =?us-ascii?Q?ooNNDuPnAphU4kbSSPd52yadVFCRWSIcYRHNPU6Tp/KFFSKqhdBNLyIyAfa6?=
 =?us-ascii?Q?uS+OkBmdcVaGjaNFpHpwOhldNaS0gyTTEiWEM7Xt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c593ed68-01ec-4ce7-0ae7-08dc1cfe47d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:43.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1nrzr9kWDxSQWXaAYMlOOS8B7IDSzDhRpK7a7PsuUJVaEHFzG1jCD+u4cWwOQxvX6Luyw8IPc7pwmDETp5s7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

After commit 25ae948b4478 ("selftests/net: add lib.sh") but before commit
2114e83381d3 ("selftests: forwarding: Avoid failures to source
net/lib.sh"), some net selftests encountered errors when they were being
exported and run. This was because the new net/lib.sh was not exported
along with the tests. The errors were crudely avoided by duplicating some
content between net/lib.sh and net/forwarding/lib.sh in 2114e83381d3.

In order to restore the sourcing of net/lib.sh from net/forwarding/lib.sh
and remove the duplicated content, this series introduces a new selftests
Makefile variable to list extra files to export from other directories and
makes use of it to avoid reintroducing the errors mentioned above.

v1:
* "selftests: Introduce Makefile variable to list shared bash scripts"
Changed TEST_INCLUDES to take relative paths, like other TEST_* variables.
Paths are adjusted accordingly in the subsequent patches. (Vladimir Oltean)

* selftests: bonding: Change script interpreter
  selftests: forwarding: Remove executable bits from lib.sh
Removed from this series, submitted separately.

Since commit 2114e83381d3 ("selftests: forwarding: Avoid failures to source
net/lib.sh") resolved the test errors, this version of the series is
focused on removing the duplication that was added in that commit. Directly
rebasing the series would reintroduce the problems that 2114e83381d3
avoided before fixing them again. In order to prevent such breakage partway
through the series, patches are reordered and content changed slightly but
there is no diff at the end compared with the simple rebasing approach. I
have dropped most review tags on account of this reordering.

RFC:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/

Link: https://lore.kernel.org/netdev/ZXu7dGj7F9Ng8iIX@Laptop-X1/

Benjamin Poirier (5):
  selftests: Introduce Makefile variable to list shared bash scripts
  selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
  selftests: team: Add shared library scripts to TEST_INCLUDES
  selftests: dsa: Replace test symlinks by wrapper script
  selftests: forwarding: Redefine relative_path variable

Petr Machata (1):
  selftests: forwarding: Remove duplicated lib.sh content

 Documentation/dev-tools/kselftest.rst         | 10 +++++
 tools/testing/selftests/Makefile              |  7 +++-
 .../selftests/drivers/net/bonding/Makefile    |  7 +++-
 .../net/bonding/bond-eth-type-change.sh       |  2 +-
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  2 +-
 .../drivers/net/bonding/dev_addr_lists.sh     |  2 +-
 .../net/bonding/mode-1-recovery-updelay.sh    |  2 +-
 .../net/bonding/mode-2-recovery-updelay.sh    |  2 +-
 .../drivers/net/bonding/net_forwarding_lib.sh |  1 -
 .../selftests/drivers/net/dsa/Makefile        | 18 ++++++++-
 .../drivers/net/dsa/bridge_locked_port.sh     |  2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh   |  2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh   |  2 +-
 .../drivers/net/dsa/bridge_vlan_aware.sh      |  2 +-
 .../drivers/net/dsa/bridge_vlan_mcast.sh      |  2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh    |  2 +-
 .../testing/selftests/drivers/net/dsa/lib.sh  |  1 -
 .../drivers/net/dsa/local_termination.sh      |  2 +-
 .../drivers/net/dsa/no_forwarding.sh          |  2 +-
 .../net/dsa/run_net_forwarding_test.sh        |  9 +++++
 .../selftests/drivers/net/dsa/tc_actions.sh   |  2 +-
 .../selftests/drivers/net/dsa/tc_common.sh    |  1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh |  2 +-
 .../selftests/drivers/net/team/Makefile       |  7 ++--
 .../drivers/net/team/dev_addr_lists.sh        |  4 +-
 .../selftests/drivers/net/team/lag_lib.sh     |  1 -
 .../drivers/net/team/net_forwarding_lib.sh    |  1 -
 tools/testing/selftests/lib.mk                | 19 ++++++++++
 .../testing/selftests/net/forwarding/Makefile |  3 ++
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++----------------
 .../net/forwarding/mirror_gre_lib.sh          |  2 +-
 .../net/forwarding/mirror_gre_topo_lib.sh     |  2 +-
 32 files changed, 96 insertions(+), 64 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh

-- 
2.43.0


