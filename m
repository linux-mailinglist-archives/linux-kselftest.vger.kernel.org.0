Return-Path: <linux-kselftest+bounces-33557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A3AC1A0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4411C04ECE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B952036EC;
	Fri, 23 May 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b="W1TwDliP";
	dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b="H+1CLR28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fallback4.mail.ox.ac.uk (fallback4.mail.ox.ac.uk [129.67.1.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540C2DCBF7;
	Fri, 23 May 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=129.67.1.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967057; cv=fail; b=fmOKBJqeAc1fBg1ZiyGqqNDHkzi+nzj+yFziSWIazNTSKZVn5+ZQjnaQcPQjCjtonT7mcxjpk4UWNDGLTQtOZ0mbBaepu/dTxr8OGE4cxG2eLrknBs39pGvP7PuHyyngvcIJHNvGjU88GWorkrLQXaaI5ZrmK9J/vkfV/PNukUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967057; c=relaxed/simple;
	bh=M1cFpS7HNX+8l7W6JbrQDMwQaIUXrAtSs/m1P8RlI10=;
	h=From:To:CC:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igv+qOku2N5crdR/rBJKemlNLyZkC7jP0DX8fyEANwfJ/uAv0AkniRwXcRn8/kS4l9J5lSK9t8yvAn7W/taxU5ii5STFfDS8oDxuTWJFl22QSqe5eX1TnJIquRHjd5+2Ntp+kIxGjnhsn9FZtRX4Z1Ci6raumniPwQ0QQcMJJE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk; spf=pass smtp.mailfrom=magd.ox.ac.uk; dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b=W1TwDliP; dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b=H+1CLR28; arc=fail smtp.client-ip=129.67.1.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magd.ox.ac.uk
Received: from relay17.mail.ox.ac.uk ([129.67.1.165])
	by fallback4.mail.ox.ac.uk with esmtp (Exim 4.92)
	(envelope-from <praveen.balakrishnan@magd.ox.ac.uk>)
	id 1uII4r-00062p-GN; Fri, 23 May 2025 03:24:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=MIME-Version:Content-Type:Message-Id:Date:Subject:CC:To:From:
	reply-to; bh=XSChO0CskaGPBS0SuvpjRK2fWB9IOUTEoNGTiEQw6F0=; t=1747967045;
	x=1748831045; b=W1TwDliPxI2z4ALNmIalQW/KFMY8BDxnX3LTEIq7hE9GvRYzOnX2oqyf26/US
	q8hvaTjNwgGwY07elun8OcxTfQDKvQUS2voEpBRGuZtuQmBYMzLXBTrhr5gF5kIcofPRvd3q0uvrh
	P99K/ekOzZVcjdoxeeyFCaC6AscQJf8r2mkqIUrQwxr8wDII7Z8wJmdWE6mbTkmHkWCPfZNwqiizM
	Ia81Ie/kN73XjBS1pLdamcZ/8h5GyBkqfC/JlK8J/9w1wUWWyNsQmcE1nwXPt26G82rROZlu+bB2+
	p3q9KgjzVdpTHyJ6TETfY6IEKSFWO0McjI5Cq4cCQj5BftP58A==;
Received: from ex01.nexus.ox.ac.uk ([163.1.154.241] helo=EX01.ad.oak.ox.ac.uk)
	by relay17.mail.ox.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <praveen.balakrishnan@magd.ox.ac.uk>)
	id 1uII4W-0002a0-6F; Fri, 23 May 2025 03:23:44 +0100
Received: from EX03.ad.oak.ox.ac.uk (163.1.154.243) by EX01.ad.oak.ox.ac.uk
 (163.1.154.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 23 May
 2025 03:23:42 +0100
Received: from LO3P265CU004.outbound.protection.outlook.com (40.93.67.4) by
 EX03.ad.oak.ox.ac.uk (163.1.154.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Fri, 23 May 2025 03:23:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXCF1zOlLD1LTRGx77B5e5cMfrHfeHLJwPH5q8jJgqwYqGEIissJK5xXa4dwKozCFfCU/Enwc04K7m1I1q0IWgCaIusTcn3FlB4VAFobk0Im0p5c4T5HKic4e5HVcFVdKX1UoE+5jS9OObKwtS3lRg5UCBoLMjMhB6BI6HG9LVwZ+txsV5da6Mw+bxrlHMQdLkFzqWEx2yZivL85oGa9EZd+yPVn9//MFvYvr3Oyng79Sk2zZRNmiDoqAEgrDRqUuBfXRTR+ebB5R3YGZHVz1Xk5eJdr2hvdC+DJ2dp5WC2WFdZwL+VPMEQf1ExePRthr7kCCEuTDv91XyAKTbko/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSChO0CskaGPBS0SuvpjRK2fWB9IOUTEoNGTiEQw6F0=;
 b=lqQpJr6PObQMh5HmlyPK7pSgJ3ZQvLp9pwMad5Mqc/zunlo8Ulo1Mv1suLDoOaY5jlUNqtXdgVGQTxtdLqYeF81WywWFmPEjvn/UR5eX/zxRTo3mQhK78HMoIPCUf4/I3lG5dubiOPeiGc0obCfvzFrpiW8uVYaNulk9KHj3T/Ovfczh2AGNwjl1kcqXSut0m2JWrB4mseGmpLOoZ29xP/eEiVnrH4s+AcW98vMPcY94f1/giSxUBaOuET2f1ZDVYVNBXUcFwpu7KK09Ei1YbucIKdjORY1NFLKuamlydS2p8MiADiBySQklct9CewapZCOML5tqESb9U3DauyCdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=magd.ox.ac.uk; dmarc=pass action=none
 header.from=magd.ox.ac.uk; dkim=pass header.d=magd.ox.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UniOxfordNexus.onmicrosoft.com; s=selector2-UniOxfordNexus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSChO0CskaGPBS0SuvpjRK2fWB9IOUTEoNGTiEQw6F0=;
 b=H+1CLR28v0l8wjkPCaW6C9AgwGeuhjQmSfqx+bxeihWxCAEkR7f+y6TGyFv8BlXv237UgNIsfn/zkT6jOUC00Qq5DcTYrSENgF9eA/0hYI5XsgZs43vTtIRdbv2460ouWhqBB84t6vE2B2ErIL9nzAgejVLtN4Gb8gfYHt25quesiyL2zZcovfChnY2uaYcqLbpN7+GeM/e35TLNsWRTDtIs/zFwpVZ2pi1tp51fo6iohx6JZB4AG4hRsxvqhwwkqihaTj9F0uX+6647DjUIGmNqY0oMJWYOAO+Ty+ZNG1ENhk6NvXobthhcC36IcVjtAZzZx9Sq/sVZ1RvDS3CWkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=magd.ox.ac.uk;
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:323::12)
 by CWXP265MB3447.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Fri, 23 May
 2025 02:23:40 +0000
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd]) by LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd%5]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 02:23:40 +0000
From: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
To: <pablo@netfilter.org>, <kadlec@netfilter.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <shuah@kernel.org>, <aconole@redhat.com>,
	<echaudro@redhat.com>, <i.maximets@ovn.org>
CC: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>
Subject: [PATCH v2] selftests: net: fix spelling and grammar mistakes
Date: Fri, 23 May 2025 03:22:42 +0100
Message-Id: <20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
References: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::12) To LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:323::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P265MB6985:EE_|CWXP265MB3447:EE_
X-MS-Office365-Filtering-Correlation-Id: 984d92c1-43f3-43ca-7040-08dd99a0d4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|41320700013|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jOCktvS4TaFHQV1j4Qa7nkUtWuAI4RAqPMV1XzSFRtOfHPtynxKNd2y0uSJZ?=
 =?us-ascii?Q?buF4C4G59Rx6eEdi5nqaDy+mlyMZ9EJ2y/FjuzcPZNfPkAIw8L6nTvAarldJ?=
 =?us-ascii?Q?pB2BhKBBWENXyzn8Kom5lSnn5har90JoaPqHKa1JhUWYmODrq3LqROP7bFMH?=
 =?us-ascii?Q?n2SKwG3iZdbGdhjTerlFwKvu7Bz+dk0HRSNS/QG4WSkFqs0HGm4NXsX+tpTM?=
 =?us-ascii?Q?SEB0hRgiWFQlR8Mul4NjwoEABnUvsdq3AnDm2/LIT4N/tBRViUr1sAQm8o5I?=
 =?us-ascii?Q?zeAGGac+gpOrZfKw7yhIO8waa/nX4TU1BMWe5kwWPkPre9rlwZnmvTrEBSPN?=
 =?us-ascii?Q?Gl0Y6tCvoZToTsEl9Gxd4zBuc9XBM5FJ1NyDDt91+rcPpzF9wDjJxIBvsQ76?=
 =?us-ascii?Q?bXB+e5UiVEgPAcvEMppMmowxeGWSHUVuyUnd9mfayhFjzD9HEIHN1aqnRX6+?=
 =?us-ascii?Q?Djrd1JMIsyhS88H+LQyvFl2+wIB6uMZXJyf1/3MpuBTDYNOlk8Sz6ZBdlpwL?=
 =?us-ascii?Q?eGMuksweJtszRA5DwpItpf8fWjqycDP/5K9kyUf7LqjlYXUlFXW93C2QZguY?=
 =?us-ascii?Q?Y5CV4lK1Dmm8pwiZ1Hfzo8pebzzoeKagIj7ABTzYrGhJZDTNrJE2HVXmv585?=
 =?us-ascii?Q?YSxOwgexeoEpk0++pf1yzhZI1ry5HMRKs8VA8L9OtWCn6Q8Dw/ErKhiA/M0P?=
 =?us-ascii?Q?2odgd3Z+4Cp/wplYUG6N4vtmfbAI77UkW2w+nopNvBCNwwbIK+vOMK8QDddX?=
 =?us-ascii?Q?MB2rC5Zocp9Kaw9GGO7Mn09gVynoyyTekdy3zdcDoY0hb5l8X12YdvkurtFQ?=
 =?us-ascii?Q?NUpB5CEHAQOvJZOchz500Y1ZeVpQn7WzO45kd44d9NIFuR5ImJocc6nLni+4?=
 =?us-ascii?Q?zfT7OR9GrhskcnrFnQr3NCKuLIAogAPMgeJ8/G9+oF9DmY656mjQGyAAuDWx?=
 =?us-ascii?Q?R5D2tV84MXqNijYGU+ycojeHAuDyyUBe1gP/EJmHL7Ljx4FU+qa7jOIBNHRh?=
 =?us-ascii?Q?oocEMgI5+8QKWK3Gs5U9pPxftFjb2yotYh6AUVz+P421fY5bEBIp2c9yxQYF?=
 =?us-ascii?Q?kuH/BlpmdXJbRNHtRv7hn5f8u7jj10ZOMRlA4+D/B0wDcp136wQ6LjCGS0/h?=
 =?us-ascii?Q?hEE4FFAg4gmJIyW2P2k4IRQPkx6q3ZPrmleAZTXyQM1NMzOap0Gzm0UjuRuM?=
 =?us-ascii?Q?ifuNg0JV7Ty8wjmJq0X5lDt+5eHIKmL7DQXA5aT2iA83bzSAZCoAXC7VBW37?=
 =?us-ascii?Q?ousT/QCBjHQvMTdDnxS9EB8FedKAESe28/YFwlKK9he7XmTEh67Ud6R5uBPC?=
 =?us-ascii?Q?Qc/RkXTktA2BjEHBcO4yhlCn4KM/36WOVvrKqciNm2VOCni1fWSy3oDSv/Yf?=
 =?us-ascii?Q?jUm2vRpNY5ui+O31pUe7SC8Q+bdTXdukFZ8iKm/E1/HijWpzPxCFqwWVcqS3?=
 =?us-ascii?Q?ifEW1x/06fvTmihUydWNI5c9/hBBJTk+21p4kCkix/puueIARERyNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pq+wu5nw0e0XY8LSOhZd2cC2yCGf/58j0tRrbqsFc7l5qH+KPLIbeC+M52BW?=
 =?us-ascii?Q?1vojKNfuROM1JIbKhHjGML4nGKd6DDUYuAp8GUjBVLv6TNdklvgs5cB3Z5/G?=
 =?us-ascii?Q?TPGqEe4uNEPbmArW/fxLMoPbWRn9WbvKLnraHvqDwmGLnTe+82F+0U0ZkXCT?=
 =?us-ascii?Q?h+Q5LLA0zUiozYMEOEGmHsnDAyvxZ23VfDU7TaRuzZWvQ0JZVTTUSKXHl4EV?=
 =?us-ascii?Q?EFxuxajq0Xr3tlYl++3sivoE0C30MGq0+Zu3iv5KT3zJ+ZOYgtGDbHCFCLTh?=
 =?us-ascii?Q?A0oL/IkCtad0FNmkajhqPsbIRgV61RFusjpvcXDJ5NfhELexdGWsZZnhtnTN?=
 =?us-ascii?Q?tYBQ5kryyUFtBXPQcHP/qY9kHzF1hV3sBBUPrrIfgv4M3/ClYyWbrAUWHJGx?=
 =?us-ascii?Q?QdU1V2XsXBsvl4Cwrb2a5p5UcPs+9voYRXXFHlvMNU645idEZw/PWIT+QE//?=
 =?us-ascii?Q?YlKtPQpB5rM/3NaJy7OW6SiAN54a3cafuFQfsm6aa1GakV8y4MipEu3n6UQ7?=
 =?us-ascii?Q?p2jP7Lk/Z+cfkSba8VWpOa/3x7fr8y2LnZhTO/uKXVfa72YXUKKnH9oAY5g/?=
 =?us-ascii?Q?RolQ9bH78qUmQAVwtpMzlfu02bO/ZpDRUt+wcU1Szplsl5KosQcGVAQRW1j+?=
 =?us-ascii?Q?R/XvVblP7FT6YaHI39Q6I5X5M8VQggenlgp8nzLkzw7W0YQwYUDQ8/hMDI4E?=
 =?us-ascii?Q?vq+5fL5gyPMbC+KBlFe9mrQ2sBQ/XS6BzAtIBEQFiSVcvg+rCPjgu+Me4cUa?=
 =?us-ascii?Q?9OhEFbHOM4wjozRFyYuT6nusjz7ch/PqYJDEaeJiWIrywjr0bbuzs850+/q0?=
 =?us-ascii?Q?s8s8jBEEU9ooltD/VzafCixJ9tIiL2Dwj+3RaSDckqeuv8WjJ+dd8RZsOYnR?=
 =?us-ascii?Q?hqCFjWoBR1ek0r3ZI9kcrQOzMlJ4M3laxGAk6GNLqC+Oxa5GHcHOrHN1PdwL?=
 =?us-ascii?Q?ub9qxo/3pXtkZs5tSc/RTKlyRSrLkVM6OJIk8Qx+k7EWjDu0QS+JeI+ffOwW?=
 =?us-ascii?Q?Kg4PVQ+OQd27tTcOAFZ5a5RqrBGycD5jdWW/kiPw9P3HlnDmqW1L9LZzPhAI?=
 =?us-ascii?Q?Eg6A5u0IzxswEBoLhEjWZj53+whdg58oVC9StOwot4hPtbljROwpkwXjh4FS?=
 =?us-ascii?Q?RSKAZHOAZ4nLy3NgXRvKAwJqkDt83XyRsYHvdbtytu6ff1LLDtkqQxxI+z/k?=
 =?us-ascii?Q?doLfAcoRg1EFUetDm+Wp5gnzJROYOHaIefEu31UwdqRWgpBTcsJn9XDMmB7X?=
 =?us-ascii?Q?N4EYdMJUp9Uefg4bLXAYN8lRkz84BJGhWQR3sIckR5tviwPrC53dX3B5LA5q?=
 =?us-ascii?Q?jMH0Qsx0H/SB2bRWljHz3zfYw0n5QqBoRgphxXKCyAiwUuJu3HBmlEKY3xw8?=
 =?us-ascii?Q?9eVws6OI17bVUZFca/Z59Iue4jwWNVz0DjAStUg4qL67coUYSWIiD/poTh3B?=
 =?us-ascii?Q?L377UBwGzJC/cN6se0aZktKg5LFr4Dkti8tr4Vs2CVkrZGJOk3ElgR/DTs/2?=
 =?us-ascii?Q?55b0WGYJCsgQpjiF8YOMncyuTNmwmZmP1vjXi1y/sKC5IBLwJwtWzTZhtQSJ?=
 =?us-ascii?Q?W7/laE3ZvY6o6GBNubEyb3v0YRSJ+O8UJ+mj2G5u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 984d92c1-43f3-43ca-7040-08dd99a0d4f9
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 02:23:40.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cc95de1b-97f5-4f93-b4ba-fe68b852cf91
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqogGEXrcpM4HPUwQc1DfEHu5IuyVxb4jnJWTVoys9PDsTDM4QfklWeAoyGSHITMkViP5MpVnUgvKEcOdIHv4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3447
X-OriginatorOrg: magd.ox.ac.uk
X-NTG-DKIM-verify: pass 

Fix several spelling and grammatical mistakes in output messages from
the net selftests to improve readability.

Only the message strings for the test output have been modified. No
changes to the functional logic of the tests have been made.

Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
---
Changes in v2:
- Resending to full recipient list as requested by Shuah Khan. No code
  changes since v1.

 .../testing/selftests/net/netfilter/conntrack_vrf.sh |  4 ++--
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  2 +-
 tools/testing/selftests/net/rps_default_mask.sh      | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
index e95ecb37c2b1..806d2bfbd6e7 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
@@ -236,9 +236,9 @@ EOF
 	ip netns exec "$ns1" ping -q -w 1 -c 1 "$DUMMYNET".2 > /dev/null
 
 	if ip netns exec "$ns0" nft list counter t fibcount | grep -q "packets 1"; then
-		echo "PASS: fib lookup returned exepected output interface"
+		echo "PASS: fib lookup returned expected output interface"
 	else
-		echo "FAIL: fib lookup did not return exepected output interface"
+		echo "FAIL: fib lookup did not return expected output interface"
 		ret=1
 		return
 	fi
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8a0396bfaf99..b521e0dea506 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
                     elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
                         up.execute(msg)
                     else:
-                        print("Unkonwn cmd: %d" % msg["cmd"])
+                        print("Unknown cmd: %d" % msg["cmd"])
             except NetlinkError as ne:
                 raise ne
 
diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
index 4287a8529890..b200019b3c80 100755
--- a/tools/testing/selftests/net/rps_default_mask.sh
+++ b/tools/testing/selftests/net/rps_default_mask.sh
@@ -54,16 +54,16 @@ cleanup
 
 echo 1 > /proc/sys/net/core/rps_default_mask
 setup
-chk_rps "changing rps_default_mask dont affect existing devices" "" lo $INITIAL_RPS_DEFAULT_MASK
+chk_rps "changing rps_default_mask doesn't affect existing devices" "" lo $INITIAL_RPS_DEFAULT_MASK
 
 echo 3 > /proc/sys/net/core/rps_default_mask
-chk_rps "changing rps_default_mask dont affect existing netns" $NETNS lo 0
+chk_rps "changing rps_default_mask doesn't affect existing netns" $NETNS lo 0
 
 ip link add name $VETH type veth peer netns $NETNS name $VETH
 ip link set dev $VETH up
 ip -n $NETNS link set dev $VETH up
-chk_rps "changing rps_default_mask affect newly created devices" "" $VETH 3
-chk_rps "changing rps_default_mask don't affect newly child netns[II]" $NETNS $VETH 0
+chk_rps "changing rps_default_mask affects newly created devices" "" $VETH 3
+chk_rps "changing rps_default_mask doesn't affect newly child netns[II]" $NETNS $VETH 0
 ip link del dev $VETH
 ip netns del $NETNS
 
@@ -72,8 +72,8 @@ chk_rps "rps_default_mask is 0 by default in child netns" "$NETNS" lo 0
 
 ip netns exec $NETNS sysctl -qw net.core.rps_default_mask=1
 ip link add name $VETH type veth peer netns $NETNS name $VETH
-chk_rps "changing rps_default_mask in child ns don't affect the main one" "" lo $INITIAL_RPS_DEFAULT_MASK
+chk_rps "changing rps_default_mask in child ns doesn't affect the main one" "" lo $INITIAL_RPS_DEFAULT_MASK
 chk_rps "changing rps_default_mask in child ns affects new childns devices" $NETNS $VETH 1
-chk_rps "changing rps_default_mask in child ns don't affect existing devices" $NETNS lo 0
+chk_rps "changing rps_default_mask in child ns doesn't affect existing devices" $NETNS lo 0
 
 exit $ret
-- 
2.39.5


