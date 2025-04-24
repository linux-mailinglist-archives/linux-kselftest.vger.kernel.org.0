Return-Path: <linux-kselftest+bounces-31609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C5A9BADD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 00:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7B9A40CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC028D850;
	Thu, 24 Apr 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dunVkk9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EC288C93;
	Thu, 24 Apr 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534282; cv=fail; b=dgOh/ICAPkbdC2SAbBFiFCBWpD+fk3wg7KNvx6Y879NZIyXUjrNEq8s5Afe+K86QMuyhj0AkfVC6TPlHKH0Mm+HT8fMehiV0bNv3iVieYeRWQaPR8kZPkQ99qaT/iFtnaetCmCmVGoiCSOXFAWBxyY1jcvLS5rZLPIsIa0uhdxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534282; c=relaxed/simple;
	bh=Mohto150kqdZ8lOQzOz4/DGcBizo25ShgcFUo8ckgMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l88W7pzTronbMr6YjuiFsOvAsdFnvoHIDgaAvkh3i+QIgwZmJGedEBtXFv6QcKrK2JaKdQZQz1vm96BSiTBo7YosST3KHdYSfS5tj1xFvfLoOYJ92iTPd6I99IP0bmjcJbvChEJvVDTv4pObJpMPHOh/ikD9T+eUwvaNueiktnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dunVkk9L; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5XKe3PT3of1nQFkFfsn02YSAA2XFZ2mR4P94wd7Fg7AxZ6JMAXVyL+/zdzUFS8CifBrHMODsl94GPF6rPZRHMB7FsDrPuBNIgMydbmro6j8Pt3dlz9HOZO+msG2CAfkWIzd2/HCmfvzC85yL3t3i+q3SLm4cBYw7pep4jILtfuCIS8LZ/MrAZsLH8GzVk6Us5gFdXmEqo7UgVI9zDZrOEfMWkIbMnGnUZB9C1NDKQVxloxRTeBVs5Mg8wtFXBiASE+Dp8wbB52OEFN8VGYKjGVrSKCrDuba4R5995w53ZwzuEkAuCVkN1q4XlSoC+PcNgiNY9NsLcN1MNRklhoA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njH/1lbPIcSzkDXgZx467OkNgWUwRWdh4wmlVktuiEM=;
 b=u0+VQY40VlvpKS5iXyIRMPIc29jQ9TQ8lbZi2p8S0EXn+5RYKJmUq6kwEbB5rmHK0/xGONVuTf9UKRNH1sqgC2Wo1TpVHptQ6ueVcDTZq7/MGNW75hwYuNa6XgF2D6iN3octiOnVXtlrejIdaqaWjFdikYNcUQCX76LM3WcDFohBJcR7HN0QZTdETzq60aJWDFPA2oKsvd6RXs95CbRKhKztwx3Fqm0K5/pBh1n2Xrwpy/3P6yZrSUm4AuzkX1AyRLU6QBAiRha46wU7K2lFj7PDd5Ew9X4HXGoMS7HTLtS6LWz8RlrG0s4xCxHdXGhy18myRXP+AGdvItjCORUofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njH/1lbPIcSzkDXgZx467OkNgWUwRWdh4wmlVktuiEM=;
 b=dunVkk9LL5OiCE0eNkXBBKQfl5omLtE55IC3EEXFAv9f1qQQkA1fkWyCrEuroG7oOoKFT6o4xNJQuDQ51BGzoG1kFSan1Rmp41OBr/kwP9lPwJkdD9TEL8ytM6JudDiaMaLDBNDkbkVhUlCq69twFUmi6pHAl+KWVVxYQqB1lqniC7lacsJVizmkJQVzoys5ul2AJN5+X4Kt9PJD9qd/9OQLC49dGBUJ59wQtCG3vBlnaNlJfNHY4VwqxmhdbPL3fVmPX2q4AtiK6e+20CcL8eZcb753B82Mhbu2Lse8zg/1fJW/PEjjv3YAr4SDEXoBP067dKSrcHUsi5n472Gh2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10396.eurprd04.prod.outlook.com (2603:10a6:150:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Thu, 24 Apr
 2025 22:37:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 22:37:53 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/2] selftests: net: bridge_vlan_aware: test untagged/8021p-tagged with and without PVID
Date: Fri, 25 Apr 2025 01:37:34 +0300
Message-ID: <20250424223734.3096202-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
References: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 74425428-a91f-489e-f4f7-08dd8380a698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l0QskQNv89V9EWwGsUhBV9zNpkC8jnMX/Kfl9jy6OboEzem4HMzJGh/37hyc?=
 =?us-ascii?Q?8+f0pNf0V7P2HvgDwUPZTlq9LvUhxGLl03R4pqv4fCHYOwS4agCZqQCy5EtY?=
 =?us-ascii?Q?sUGCWmV3mL6ZvO1mOdYuJpcVhTh0QEoACLdlh/lr6mieTwDJAwiGJ2Un8v3m?=
 =?us-ascii?Q?e1PIPjbULcYwc5nqDlprJxDxLqDpx5KXz2RMbgRrLbab1VqgXem56wttWUfm?=
 =?us-ascii?Q?LRcQDhdGozzq3sLbQPwGHm7Xt+at6/LAvcLeu4oBVBBtLKb7Oj7aOc845H2s?=
 =?us-ascii?Q?tu56XzvyoQw2rIaXEwGL0L7TPbOlAsyo6RuX8x5/74SmZcRCDAs4zZr8ekoH?=
 =?us-ascii?Q?0KAQPZykzE7qHybZp8305eLnwnbx0Wf74I3FYsSLm1Cs5eWC/kCp5FWm+V5b?=
 =?us-ascii?Q?iP92vITIZ6L3hvPck+2NZIf13K2Yd5KGNqtpnYqNxLs2/5w5TmCBdE7BB2d6?=
 =?us-ascii?Q?vHwrW72mn4wBBYZeMQLQtTLFV9SUJ21GpeVk/zKySGIhy5UU2CMvXwKnPiwa?=
 =?us-ascii?Q?3Yvt95n4vWWPaelaE1RIIlPwXkA4nfUUSFcYIAvcQuDJyTnc1yo0ceUkkPCV?=
 =?us-ascii?Q?FPt/nbp7cxpZMf0X5b03dmud944lBRqXzYx6FexDNc9z4f1L6Q/rp6sKmJP5?=
 =?us-ascii?Q?TBeg0kyjFDYAQLylNDNhfNpFkXgzPKs+stboPHMZ67lKsYoPykH6Oa61Y58Z?=
 =?us-ascii?Q?bmAdwJhps4RCgw8x0A/x1l95quLM3GhSvvLMWiiO6cM/cyUrqKFjXqC8Nj1G?=
 =?us-ascii?Q?Z9ITCniHMZajPIxh38lBXh4icRklFAyh583aXQk4NlmXCxM/pvW/CKh4GBGI?=
 =?us-ascii?Q?BU1YaGENAjEv3cKvUfCjenGN7uNHlu7P+4pYEN87itKNJ6rNE7kB3NFii4vi?=
 =?us-ascii?Q?gfgrsCG8q6WjwBcAdyHIyyIu1cjZ13n3sdpsfRw7fJGqFD7tyT+4Z/39U7IM?=
 =?us-ascii?Q?eSLXBGyOWAvT9uYCFHxXsXa2GgDrZGw2ExCwc9RQrM1RWkkpSzMl3S+KHe0X?=
 =?us-ascii?Q?iwwO6/v47VMlbFUj6pmnNAQxZXTbckjYWTeZHs2LNw0J7i/tu7LE5RZDec7m?=
 =?us-ascii?Q?n2quQQJ0C8ErNXFu3MMfSnttaxk7rSQ1XS5SJmVoBLh4lTEzp3YTk5r3+F4a?=
 =?us-ascii?Q?bcPN2ZkgxLwVSlt8F8HDYtZE0IOkt4F4H4OwubdCuqtoOBOCkYUpH4jwlL6M?=
 =?us-ascii?Q?0mw/aXVy4zNj36aYl5Wut2t0DnP5dLrum36oz+E0YcAO7GM7tm6l0Wbn2sgk?=
 =?us-ascii?Q?PEW+8/NO7pkwm//BUGRu7tEmk43Qn3i1spPp449Hcqh5zR3Q/I0gE2DrTB/O?=
 =?us-ascii?Q?iNVl+NW2dhGVOlZoht6lCv1ZFA6u6uKQWF5VqzLywbSCQD1NWurRj1dpXMBe?=
 =?us-ascii?Q?0KsO+jKxZ3dF8EIB8WXmSkPR7aHw/gX66k/htx/dcMXKxh32RpPKYU++weLb?=
 =?us-ascii?Q?f4Uh3iW+sWsTFcpoRYttuSAAKqRjm6hK5Ig1ALYf9C84/z8PRVQnLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TB9lHXGNOzYOvBiGhaljTeDhjcJkqSt2kFzATTb5UqnpPukNdnZjmWgzTtjX?=
 =?us-ascii?Q?7z4BLSTeQay7B1PD0pCL1UJCDU1nJlfj40A6NMh1oi/wg/lq4ZrfQ9Yo7hFV?=
 =?us-ascii?Q?I9tIink+2qLyba0cR3TNDWm9qtiJjmnh8nv20AMGYSRMMsUnHMPc8Eoh0okR?=
 =?us-ascii?Q?Jhj3TP9Kib8c6SGzlFxQnt/A6SXGlOfQ7PSRTCetiaxnIwbmlSiq8snLokkt?=
 =?us-ascii?Q?V8Ac3Td7IiNPMvOSpLFgzyD6skdWNMCk0e/8XhBotqhVcIK74IZOz6IL8ciR?=
 =?us-ascii?Q?c4TOtiUtS02yxnUmp7IEtUWiHqqRjYq2cpZQRMIkTp8Kh1BBpkS5xal+2/Um?=
 =?us-ascii?Q?xlNekY5P1m1RMZtqnK7RlhoLkVRMXk3aQKzkmCHF0slNYhuX0CZgSxT51rUz?=
 =?us-ascii?Q?UH+5WUjJzwL3hoA5bAP1KNvaqSp+QmGhEbJcGBA+VlO6eauG+9eiNe8ho9sY?=
 =?us-ascii?Q?Mgx/Dgna9OtAaACh3rZlsZ1NxGYPhSU9AbTNgyePxTWy+vIPElj23irFxmZj?=
 =?us-ascii?Q?VdhiTVoeTri4zht6dt1vCXNSF5RTL7LewtrUoAXJG46NhfMXzUKSErkelcQB?=
 =?us-ascii?Q?17MhfeOiSIk1QNXh4TRkzqqKLi52Gg1Iumyiz0y4SYGpZXDqy9vYqqRb0WnC?=
 =?us-ascii?Q?XFiMnsyAIxaKavWr69wC/WQj05120IKDiDOaalsXJnTR4/wclWwt+QZhlcs2?=
 =?us-ascii?Q?QyqllMYrPEYBLyUEt87E4m/2XtZpGtICnuWCW5AP4s/eUsHSACvYWK2L/0U4?=
 =?us-ascii?Q?UNYpLH/LoIUzX+5dJchJGS9PkmpBwQZ0jgrnvJEhz3mk/agKD2h3gMuuwB9q?=
 =?us-ascii?Q?KDQd8MM+4kwNC4To4tf8TkkDYPoK5G2e5SOql25vodrGxs6QFuaOPuRISNZk?=
 =?us-ascii?Q?V7gaKSG/TQ54Pcox+tACc/VROSPTm/jjUDbfUdCkRLziCG7tAWjQ3NtgzvDG?=
 =?us-ascii?Q?jlwoYQdY6RMzADsDcS2xAFUHOJimdIiCb7rtMhmQYMLxXkaXTSL3J3S/bc00?=
 =?us-ascii?Q?GVE4fX8hb1eP7Ths5hv3Bkb64GQf/s447RI3lyYlqOMGDHW4s7XpOp4luEAO?=
 =?us-ascii?Q?F1vI+BmdSPu85WtPl3u49zg0nTib3wgHBALkKLTGjcn3rN2HSZT8HltMm/MW?=
 =?us-ascii?Q?oEsyYPKthtZvKSRapaC4ZtxowgvRuIgbvG2OpDIAQggI8mCUAVNtLSLx2PS0?=
 =?us-ascii?Q?6QhD2mvQlUbJ6DEZriA1sio61w7R8FwXrGYy+dSuCccJ1EkRAYQbSOdlp0bM?=
 =?us-ascii?Q?9m4m9Y2AusPFrgVlH/wb5eyHjnxCEcvwQE/0bqGUgkVnWnaw7Nd/ys1nTVkS?=
 =?us-ascii?Q?sCskwvREJEZ1rCuxs+V6UL6DoVw1dE+ex6M+g9tOucibz0Ep99IrJ1oZjHwQ?=
 =?us-ascii?Q?95XoYOvhMP3XC2lEH5vFniIYvNtKnEss3a42cfmiNbXiRN5EZFO+7fyTfWJb?=
 =?us-ascii?Q?XQV7+dKXcweEOKLc2SlAuP1fm90/CiPSWCARQKM7BpdHxVaXoQVGT4ba9Naw?=
 =?us-ascii?Q?u623APg3cY5CHveN68QAY59Jg7lI/MWJpjXgAoMlpg/x5UubXgBf2vXlMmWo?=
 =?us-ascii?Q?iC16O2KwFe6WJfu09N0WT+6spfNBJuXQUSw81WrAMxnz4sPKlDh2cFgVtuch?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74425428-a91f-489e-f4f7-08dd8380a698
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 22:37:53.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtt4bXkY/6Kdau0NlMlWDryDoOJ4QxV1UU+Tw1SfMj1n5okls5x9tFeKo7RWPLAIfZgP3j2hZjM/4NCZs61Ztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10396

Recent discussions around commit ad1afb003939 ("vlan_dev: VLAN 0 should
be treated as "no vlan tag" (802.1p packet)") have sparked the question
what happens with the DSA (and possibly other switchdev) data path when
the bridge says that ports should have no PVID VLAN, but the 8021q
module, as the result of a NETDEV_UP event, decides it should add VID 0
to the RX filter of those bridge ports. Do those bridge ports receive
packets tagged with VID 0 or not, now? We don't know, there is no test.

In the veth realm, this passes trivially, because veth is not VLAN
filtering and this, the 8021q module lacks the instinct to add VID 0 in
the first place.

In the realm of VLAN filtering NICs with no switchdev offload, this
should also pass, because the VLAN groups of the software bridge are
consulted, where it can clearly be seen that a PVID is missing, even
though the packet was initially accepted by the NIC.

The test only poses a challenge for switchdev drivers, which usually
have to program to hardware both VLANs from RX filtering, as well as
from switchdev. Especially when a switchdev port joins a VLAN-aware
bridge, it is unavoidable that it gains the NETIF_F_HW_VLAN_CTAG_FILTER
feature, i.e. any 8021q uppers that the bridge port may have must also
be committed to the RX filtering table of the interface. When a
VLAN-tagged packet is physically received by the port, it is initially
indistinguishable whether it will reach the bridge data path or the
8021q upper data path.

That is rather the final step of the new tests that we introduce.
We need to build context up to that stage, which means the following:

- we need to test that 802.1p (VID 0) tagged traffic is received in the
  first place (on bridge ports with a valid PVID). This is the "8021p"
  test.

- we need to test that the usual paths of reaching a configuration with
  no PVID on a bridge port are all covered and they all reach the same
  state.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/bridge_vlan_aware.sh       | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index 90f8a244ea90..e59fba366a0a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn other_tpid"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn other_tpid 8021p drop_untagged"
 NUM_NETIFS=4
 CHECK_TC="yes"
 source lib.sh
@@ -194,6 +194,100 @@ other_tpid()
 	tc qdisc del dev $h2 clsact
 }
 
+8021p_do()
+{
+	local should_fail=$1; shift
+	local mac=de:ad:be:ef:13:37
+
+	tc filter add dev $h2 ingress protocol all pref 1 handle 101 \
+		flower dst_mac $mac action drop
+
+	$MZ -q $h1 -c 1 -b $mac -a own "81:00 00:00 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	sleep 1
+
+	tc -j -s filter show dev $h2 ingress \
+		| jq -e ".[] | select(.options.handle == 101) \
+		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
+	check_err_fail $should_fail $? "802.1p-tagged reception"
+
+	tc filter del dev $h2 ingress pref 1
+}
+
+8021p()
+{
+	RET=0
+
+	tc qdisc add dev $h2 clsact
+	ip link set $h2 promisc on
+
+	# Test that with the default_pvid, 1, packets tagged with VID 0 are
+	# accepted.
+	8021p_do 0
+
+	# Test that packets tagged with VID 0 are still accepted after changing
+	# the default_pvid.
+	ip link set br0 type bridge vlan_default_pvid 10
+	8021p_do 0
+
+	log_test "Reception of 802.1p-tagged traffic"
+
+	ip link set $h2 promisc off
+	tc qdisc del dev $h2 clsact
+}
+
+send_untagged_and_8021p()
+{
+	ping_do $h1 192.0.2.2
+	check_fail $?
+
+	8021p_do 1
+}
+
+drop_untagged()
+{
+	RET=0
+
+	tc qdisc add dev $h2 clsact
+	ip link set $h2 promisc on
+
+	# Test that with no PVID, untagged and 802.1p-tagged traffic is
+	# dropped.
+	ip link set br0 type bridge vlan_default_pvid 1
+
+	# First we reconfigure the default_pvid, 1, as a non-PVID VLAN.
+	bridge vlan add dev $swp1 vid 1 untagged
+	send_untagged_and_8021p
+	bridge vlan add dev $swp1 vid 1 pvid untagged
+
+	# Next we try to delete VID 1 altogether
+	bridge vlan del dev $swp1 vid 1
+	send_untagged_and_8021p
+	bridge vlan add dev $swp1 vid 1 pvid untagged
+
+	# Set up the bridge without a default_pvid, then check that the 8021q
+	# module, when the bridge port goes down and then up again, does not
+	# accidentally re-enable untagged packet reception.
+	ip link set br0 type bridge vlan_default_pvid 0
+	ip link set $swp1 down
+	ip link set $swp1 up
+	setup_wait
+	send_untagged_and_8021p
+
+	# Remove swp1 as a bridge port and let it rejoin the bridge while it
+	# has no default_pvid.
+	ip link set $swp1 nomaster
+	ip link set $swp1 master br0
+	send_untagged_and_8021p
+
+	# Restore settings
+	ip link set br0 type bridge vlan_default_pvid 1
+
+	log_test "Dropping of untagged and 802.1p-tagged traffic with no PVID"
+
+	ip link set $h2 promisc off
+	tc qdisc del dev $h2 clsact
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.43.0


