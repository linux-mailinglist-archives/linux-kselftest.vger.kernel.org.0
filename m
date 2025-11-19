Return-Path: <linux-kselftest+bounces-45973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C1C6E3C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D95D4F3FD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DD354ACE;
	Wed, 19 Nov 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kmHJUzxg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E5354714;
	Wed, 19 Nov 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551335; cv=fail; b=cTnCSy5Iq7h96fqmuD0JMXM/J45u/09WAgsqkjWprn4E2cgZ7mR4BKdir2C2B79eW762fwIgYqgSZcQZNkm3NcSxSdrw5Ykx8t+Fig5UZiVbvidf/cI11onNRdSLARiQjXfNOSOZjhX0zczSIbXAhLyG94ju7+ErIKeeZEtNfGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551335; c=relaxed/simple;
	bh=VLmfnES64JSQXAvmwRy4PWB9rN2YdRWEuXjCUNSNVWg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLfv0HXHiJVlbb1uXOOXGha0Fj0j/yeJy65myOEh7nANb709bYPyXjbocQsZBQPQkxBiARs5gWsaXIt0BAjt0x58L6MaRMBTqMki19QT3TssYipUSMqnzWcuuB3ckbI4s0jm6NbdxcO/VzL5SPKvERDikSAgUv4oYyWentgRuj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kmHJUzxg; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twpL/WE6M2MFMWiI2OOcnaLNDZokEm9Ev+h7gPLPXwBfmxLMp18OF/n/JZ/FkK4L1R9lzMjJBdpqtYT7XMEQzeOT+X60YH9C6hZX/dEYv6RCrJslAMfs2Kn2ke8ngaktkMhWPHoFjMajgSjXAohUQmllQnyy+svomBkKCh7EW61DpPKvBlpev/Za7++gev05KM+leEvN59t/c6iozUui3EyxwxvMSVo8oLz186Kwz+W21Y1AuhV5+Mpxn8WVJzzWESajZGmwFOpl7ny4nO2K/sQxxE2tXkQJiaNnI6Dc2ndmd0zppCRH/DjWLghhBvf10VdUH1WbWeLwP8OFBoq0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMmEAGkgLZGCmBQO8i/5+RiG0m5rf5esPYqtZIkVAYs=;
 b=wHltJnGpG9fTEXwszmzuyGro90TdqwIAxGKrkOES7MhjE7qVgc94KsNtxf9RUmE7/5XobU7vez294CwfLKn+dzX2wV3WAlBt+5vbn3n3gL1OdKE3cJaFGAwKeXvd9m1P/2q26GAekRqQA/CA98+e9ifZVsX1KX072LuOdYdUMMUjZh+8MqonY4mmMUmT/6PW7eD29FBKX5466oyvMDTk6aNZWKpKkQ78U13LIcnWCqD9A5bV+TN7ul4IpB2V4VYTAi8g+YqIYv4Q34kmmfelz5Fq8Rb0xnl6lxcTkqmB82uQ5u+Sp68KW0xVuknmB09uhSD/kvEQe2vab9YaUdHcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMmEAGkgLZGCmBQO8i/5+RiG0m5rf5esPYqtZIkVAYs=;
 b=kmHJUzxgWOKt4NvqC/K3e8+9tmz2bkanCQE0pWFElo/kIKenda0gYjFjajCoS0fZQpd9kDaC2jfQ7Hd8nwg7i8l8iQpP377EpaPneiwvWVrC+QDkgj1A4DS5dlLcxhI5fsLnd9fpg8x1H+Hi2+iN+Oc232BM+HaB78cPjdlZ0ATqY93v/ngjLRs6hVwoe6xh2Aup8BUgES0mUwtxel4Rfuyg0Wl2XnA8Rwbs8fsbXLdxn/v5rKYDDqY4Y9yX0aSAVPHkvIXqgY5LRPMHLJtee/vWhbLht+OvmoqvI0TF7+JtdQnDTLNQoJ5pi6rz6HqH3ngoLEcIkDHIm79Qs8VstA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM7PR07MB6455.eurprd07.prod.outlook.com (2603:10a6:20b:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Wed, 19 Nov
 2025 11:22:09 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 11:22:08 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Topic: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Index: AQHcVTY/Vojp0P94/0mOC8z6JaaJb7T4W/UAgAFx7lCAAAltAIAAAXMA
Date: Wed, 19 Nov 2025 11:22:08 +0000
Message-ID:
 <PAXPR07MB79840A45F8DCE6A6956ABEC2A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
In-Reply-To: <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM7PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 34c60a76-e9ae-4696-cf44-08de275de0c0
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TBnILb2DWiqkIXv/v5/R2S7k1Byw8OdGzvlqBIvMxQzqc/5S1E6Rz5N8Gq1n?=
 =?us-ascii?Q?/6j8pUFI8uabP3KDgQeloY29xIBX4tYilEPKhwNc9Pgd2YQS+Kt+s2FYMgHa?=
 =?us-ascii?Q?fo+2n8nN3Ezq8SUuXle8lCqskOL1POUz0L5ck/ayazf3vWX6SvaIVnkvnGXg?=
 =?us-ascii?Q?t0VKojdkT5Qis17FcrHKpGfgx0ZCI7rkmXnR1K4nA2lMo2rNiUcY0LCrIdeV?=
 =?us-ascii?Q?Jx2gGV7dnGurlXL62N8hDRaCUmx7gJH7PuxK0taG2U6tannvYVT5oLCBCVRz?=
 =?us-ascii?Q?g23zGhIWWDPYWGFosfQwY7l1/WjUszw4MV3zwfO0GAj8Vplnyat9/GGjse/G?=
 =?us-ascii?Q?pzKUCgYbaOEPMp2VVn+LneAQvJAIgL7z6jkj3zVlW8+qaCWbAFYJ7yQM3CSi?=
 =?us-ascii?Q?m2pFRr/qA8u9So9/vfTomYCXW5W0+P+BL9yUhRBlKhWIT8oy8oPVdCGcWhpU?=
 =?us-ascii?Q?iUawamzGRsZSjLbz/8BJ4pKiY5OaQLQvVjGDE+wtNUUWpNJ244QpH2+DsPjQ?=
 =?us-ascii?Q?YwxdUjEud4qJXTHMd77vCQvFspXaPiCfXtvDl+fSDHCCJYCD8TFs5rDd4ud7?=
 =?us-ascii?Q?ygYG6kdx87hqW+Y2CAkjiAcutfGuDofIkhTRAZnX5e+z+UnN68As8Fn3iJ8S?=
 =?us-ascii?Q?9KM/yge1RfdHDrk/EXw23jV7e3ln8Y7HpeheQqkT6+VceSme5Bs0rZFlNK4u?=
 =?us-ascii?Q?xzgUBGB5fxH/VCPo7+5Cw5SEWslJXH9gOGtbuqxs+VaPDEa8DT+CJX0W91jf?=
 =?us-ascii?Q?8I21RHvOJZi5EdsvXY7y1RW9qkaQZjwBJGtx/x7cVa9nqclNoMh8Duuh1XqQ?=
 =?us-ascii?Q?r3+8PqVcSdq01CGhhCu1XupWp377SB0NXTI5dyhCCp/IXpWvrn0td5TjCWk1?=
 =?us-ascii?Q?BM/d6C/6CAG/swKJqfRALMHQEs437pfgQTGRB0z6X949IAs4hFHIucW8ooIa?=
 =?us-ascii?Q?aJ7mJ82VnoGxbmLTF29aOyeagxKbr3QQTrLRb1pfgGirOyRI8gBnUNfK+bRO?=
 =?us-ascii?Q?bu4olp9MXTC/KxJYuOHbUAABGXAKvzG4nm2ocm7Hsb9JNx152yGM2DrR24wE?=
 =?us-ascii?Q?MwMfGOZ3evyhjyEl9eK9EjSuHMU1Mz1C1/Wvc/Rw5WVzSf1H2+3hfm+ohKEu?=
 =?us-ascii?Q?peqdHryNyXJHCXZ3UPPlTWhiqjx10KwzqomDj1RjdzL4okyyNk22neZHeyGW?=
 =?us-ascii?Q?yxQX7SlsSTubIQH1REpNLOTO5IxweFJoyLY+7GbWMdWduxW9ccf8F2hQkm3Z?=
 =?us-ascii?Q?N+euAUFI7kKfnZYNLxiwfNQUGX/0m3ioUzJmtN5zCxEXEA0ydmXD/eQXmqub?=
 =?us-ascii?Q?T/O9pinonXVmmQJqXe6xBhjWXTVgRzyyhEcyxCIKd5xb1O7cg6sjPo/SaDre?=
 =?us-ascii?Q?pMbYgL7MWT9W5rlD/2oxCQFpzeyVxGQFVBV6GAQ7bRZrXwMdEOGuTrCBlYK3?=
 =?us-ascii?Q?qx6+8htErJgExJOaUZ6qxk5h8/LxnSp7LhgqheLb59vYDQWhnR7cvdDUYzgY?=
 =?us-ascii?Q?J3kB2ZuCNgqH5qQGTVYZg9ZF+vx5+uotktBaIokz77XeCe91k3+HacfZZw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qDfS9FrnIukUKvC7AhmW9/kqLyd1lCOvXhcgIZ6LzCDzLPZJOyXVZLQVNii3?=
 =?us-ascii?Q?g2Wer/N08i/AJFQMwyKlXZeHhj4zKe6arPd5S1Nv0ti4qrVy5grRs0p441Es?=
 =?us-ascii?Q?xMU58UzXIc/fLFltcoOSq/N6ILybb9xypo/hfU2iHxkeFyuWemcUjibilfcO?=
 =?us-ascii?Q?N7DFKrGNffF+gAdPEL0QTJ1/93DibZOKxfx5k83LXDpp8uNEX7+gV6PYcQ0w?=
 =?us-ascii?Q?k3+xb+MojarCJReLEDid0QV+u74eoTaiL/dB8fEAJv1VTzvhuGt9NsUmBLtN?=
 =?us-ascii?Q?wf5rctxFU9a0hJ156kQPOSYeEXyGLLa/6lkGBxpKqsU4hi3lQsU+3yT6exVt?=
 =?us-ascii?Q?37Wtniv4wVRGsE64obmOBGrXrirdyw60FMsdAlAiD8RxVTAqHyjQMoS+OQtb?=
 =?us-ascii?Q?k2UtyYXgfqtkPcXqVTSz0rSwZU5mv5CKWtLvL/aiB5/zgqGt9za9zlPUl5YM?=
 =?us-ascii?Q?Oy0BRnIOlRihdwSqTE848zgry13PEDG1OmyxNZirUyYviJQTKyN3TxGCyxr4?=
 =?us-ascii?Q?Cl9gapjFPDIlvURAlSm1PD33NecylWih6hNcW2oK3AAzYdQus91uqmf+AE/0?=
 =?us-ascii?Q?7TSn6B5rciqcy2YFQGqHoZErZzsUrd54GJL7hrowlGe/Z3MAokVCMzjCJ1PN?=
 =?us-ascii?Q?OUaN1mNaoO84Fnui7pluEOAQB6vvgaRNY5PHm/mQvu0XnnnxzZoEYYwQVlGS?=
 =?us-ascii?Q?XXNOsvcpPOJ70TKgZzmJfkbira6gS77zmWCwsLs82m9HNm3PXhtYY4VUo/Xx?=
 =?us-ascii?Q?PUaEhLwMHFyVVJGPK1JbqiacPkShKx4k4tPXuOMTboNvJWiGl4VmiuYetKTG?=
 =?us-ascii?Q?LsITAfJiWp/JULWwHwt87BQYQGAHYAStfzMRAZnZt92lxNajDiEdgFrdr2/V?=
 =?us-ascii?Q?tkKJHiVxF4erEMt/xCj1xMgboYV3g6njsJUxVSeTxA9yXaEE4SYgxYRepKfs?=
 =?us-ascii?Q?0yPBTSZKYTd0EkiFXXnr4i7u4DWS6qtHbVEM0t/HbfmeeUOTHeONmFAE35Al?=
 =?us-ascii?Q?hUth0HQuci+aLyh6zUFa0uQiWsdDb7jwvdY/5BBdltQICqPi+aDAiPXUs5TD?=
 =?us-ascii?Q?gVRVtcqPDkjKKb95t+3IncjokxoQariH61nsHuKUpz5J8K61LwDXPNNTG276?=
 =?us-ascii?Q?4dQIhC7JUibD41G9KdPRdzet4GJOrM4ZIoQ2fQEsp9npKCk2DTWOx9ymZ07h?=
 =?us-ascii?Q?wLslrFwPCTyD9OEq57Hg8GY1kvpnNep7lcK+dDhg7QpvHpECAh2FgKe4VQWP?=
 =?us-ascii?Q?LRLTdh/OOQ+1ywuzoPPgYy5X/cpB9UF2ueDZTZVdrRZjxwL+4ebaCvPd6suU?=
 =?us-ascii?Q?1ihV6XMQEefVumQQeD/qW+T/9TAm7aM54P7WMvtu06kZ90e+I7/IJZnFdZP2?=
 =?us-ascii?Q?lhP/aig2ISndrVCGiOB/wEwZjKYbLe5YOpJmgj3Kww+1bqvWxPKuYpGgEg64?=
 =?us-ascii?Q?dKQ85x1Qvj8jjxUn8lrkArnSG1YKWA5NZ+HDksK5LWF4U20R/cDuJ6S6VCve?=
 =?us-ascii?Q?I6B9N+3IpQmU/TPQeWs9SJIEQXZxBsevlor+y3u+0sxwKdQ6sqNStPljjhre?=
 =?us-ascii?Q?Vp2/QEKNLQ7aozJsrKdIf8AVMn9dlupmW6bkLZtLH0PEe6Qr58/DkfYysVF7?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c60a76-e9ae-4696-cf44-08de275de0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 11:22:08.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URR3GeHydPf8KnIvUxNwR0IG5F0eWtkfnpuZqsdg7nkF2firmelzur622B5BAEyJSzZGQ90rB4NCijvZcUoBiuCW+U9X09ZgTRrba9uQotqyTO0JjEqq6jGdr7rYQy6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6455

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Wednesday, November 19, 2025 11:40 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; parav@nvidia.com; linux-doc@vger.kernel.org; corbet@lwn.net; hor=
ms@kernel.org; dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org; =
netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.=
org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us=
; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@=
fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.k=
ernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <k=
oen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.joha=
nsson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire <cheshire@apple=
.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel <vidhi_goel@=
apple.com>
> Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for SKB_GSO_T=
CP_ECN and SKB_GSO_TCP_ACCECN
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
> > I was thinking to totally remove ECN from Rx path,
>=20
> ??? do you mean you intend to remove the existing virtio_net ECN support?=
 I guess/hope I misread the above.
>=20
> Note that removing features from virtio_net is an extreme pain at best, a=
nd more probably simply impossible - see the UFO removal history.
>=20
> Please clarify, thanks!
>=20
> Paolo

This ECN flag on RX path shall not be used in Rx path for forwarding scenar=
io. But it can still be used on Tx path in virtio_net.

And on RX path, new ACCECN flag shall be used to avoid breaking CWR flag fo=
r latter GSO Tx in forwarding scenario.

Let me borrow an example from Ilpo:

SKB_GSO_TCP_ECN will not replicate the same TCP header flags in a forwardin=
g scenario:
Segment 1 CWR set
Segment 2 CWR set

GRO rx and GSO tx with SKB_GSO_TCP_ECN, after forwarding outputs these segm=
ents:
Segment 1 CWR set
Segment 2 CWR cleared

Thus, the ACE field in Segment 2 no longer contains the same value as it wa=
s sent with.


So, maybe a table below better represent this?
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|               |   SKB_GSO_TCP_ECN    |     SKB_GSO_TCP_ACCECN    |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|               | The 1st TCP segment  |   The TCP segment uses    |
|    Tx path    | has CWR set and      |  the CWR flag as part of  |
|               | suqsequent segments  |  ACE signal, and the CWR  |
|               | have CWR cleared.    |   flag is not modified.   |
+---------------+----------------------+---------------------------+
|    Rx path    | Shall not be used to |  Used to indicate latter  |
| of forwarding | avoid potential ACE  |  GSO Tx NOT to clear CWR  |
|    scenario   |  signal corruption.  | flag from the 2nd segment |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+


Chia-Yu

