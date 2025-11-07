Return-Path: <linux-kselftest+bounces-45102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5AC4049D
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812764F1BB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA52E973C;
	Fri,  7 Nov 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PLg9KuPK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PLg9KuPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03C2DA742;
	Fri,  7 Nov 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525197; cv=fail; b=XJinsTd9KaH2EyHO5PAONLLaeOvJqkln4K1l/BmuET4ErQpCxmWY2kRhepOhJqfg3mDssrJnIsLaoh1ZIN3lNBthRegVNdM/tr9b9WQuEF9Ui/2PP3xT+78lf1qq3RSY4KZsv5ED460zs8APgxcEGrHtQFqDs07uZS/aNmI3G50=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525197; c=relaxed/simple;
	bh=HpN1NjakDMeQNfWqHZUOb+uTocom4ne6c7XlHPTS5l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nn9SyK410QCrUvp1gKz0h/NkMvVmVQdxQr1baj4e67Iv6NbrmpuuVTmW3tDxtmj1ZWrfLI6tKAAdOocT/vhulZ6xEApz8V0wsO3Xn36vfaw9yyzjvM2wLbyejnjCRcBFsg1PSkALk9NTEeuuHT0iVGJPxiMFN1Eds/ukrSDwotQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PLg9KuPK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PLg9KuPK; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JcIPUFXm+r/FDZLSrUTdyzOdqx3KjCywpRyy+SPKtp9IiAb3YYqP5aQVGTJi+EGg3rCR45CIu2gMvKmdsYnZOQyM8WMazkq4hPpYavM1qq6g4fncQoAm3/Y0n51Ryas4AYS57zve5RXn/qCBvjfJf4f4TSx8IBy35ySpijZPF2b+YCwyX/ovXrpfHQoNyzpAU1XCP2HP0MhpwWbS1AjQ2/2Q2EyZnlrAw/bkS6DKH4b7qSjeTjk+untYALsgH7vcIexFUSqRDEf3mmEuMW2JXeJFivTtGCLG9XOy3aEgqlHSYNLcBF5P34EkxuSUUownZ0Byd1CtjfzaCXGItmGXug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpN1NjakDMeQNfWqHZUOb+uTocom4ne6c7XlHPTS5l0=;
 b=XCmsdUvjd3dTkaMjJul5CU6iqChUoq6XLXfPrwRbZ2K6GY/AIVZA5rpy3KvmaE/Tiqz/YEPDvFsA5CNvblByJ/9HKl+Lmu98gHJGNlbbATwv7XgZ2ldwPuLMLLdaJHPR6Oe+it0NjBC4pcHtJEhPfxTvglW31yCGLaESnTNwg55N/6/43xmbonaRKArbeRmLE/+U49ULKploCMoFO+llwUVjq9M7iRti2IsMg+S1Eg5+/B1yLS4wKvo5NGguaPuN4V8idRC5EsK7Vi8hL28Qx4HyL5bjztzS1OWw3R2eoeef2YdIlqhpD+QvKp6oU4TJOnHLD60ONHdqMTvhqiZadA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=arndb.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpN1NjakDMeQNfWqHZUOb+uTocom4ne6c7XlHPTS5l0=;
 b=PLg9KuPKS+IB9LnVO9vxO6TJAU5ID4+Vo1FuIJdtVbGdQzIkPzNmgRw4mj7cTiq1nGcLsZRQbr5kowLqgHbFzRBJpwa1YmdP+zfbi6CwKEc+kEnHZ722Pgd86slqAY+0TYm5J747Lolmr3p7ewoNwKu8TiXoHapxGLDQ2ALgOIM=
Received: from DU7P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::17)
 by DBAPR08MB5656.eurprd08.prod.outlook.com (2603:10a6:10:1a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 14:19:50 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::ad) by DU7P190CA0021.outlook.office365.com
 (2603:10a6:10:550::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 14:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Fri, 7 Nov 2025 14:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB+xfjiufxm/4lpGYgmqFSMimXBUoBMDQj/wwNrc5pP1sgVkhxVtoFkOdDKvS3awqFMGy48AsO+ULCBw5girFAf1KXSSXHNRaS7M+a40rzNyn0DPs8tZHQSJ4kXWvJ3aS00RnHXv215UA8X5GIJYP6kQ5j/pWwltb0aY76nT0rPXuQgsFOHUQjPqSr7S+Nvr5WVQGElzaBdaqo5ux49ChskivY81qVxw8K+BcZW1EWbs1jUsJPsvnftv90WWSm+1vGsCeXrU30eYDqWqewocNmH/2Yv8oZzr+1MC+tZXMyqKKY3XoJIZCz3i9iIq8DROe2FctZCQCA8E62zBToDRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpN1NjakDMeQNfWqHZUOb+uTocom4ne6c7XlHPTS5l0=;
 b=Y17b/oAXnBSBrzTMDrxr93K9HslDJ1XQNcDegzm7Z4v87WA5UJd/NGs6jTFRg6AcjCcjY80CEd9p9lwchwui92MMh4jqVWCECgDPIWQW+lpOErX5Tp007D5d501sLvbqV6WMNavCdkSdwHTgGfEcQUkvjBpRiGr9YjJBjqrnlm/bJqpbTlbgqaQufymjGB2q36oOImA50ufCy81ao+WX0tgCpUxi/sUTq9wvvd/lfs/QEICScuKCHSnfDdIkGrjkm+/bFFVCWNKczFgAEIymq012akLCh0WIHyEjxiRM+bW1NPew4y9pna7MPv7+CfdLGsH5UG/A1TVTMtuwmCMvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpN1NjakDMeQNfWqHZUOb+uTocom4ne6c7XlHPTS5l0=;
 b=PLg9KuPKS+IB9LnVO9vxO6TJAU5ID4+Vo1FuIJdtVbGdQzIkPzNmgRw4mj7cTiq1nGcLsZRQbr5kowLqgHbFzRBJpwa1YmdP+zfbi6CwKEc+kEnHZ722Pgd86slqAY+0TYm5J747Lolmr3p7ewoNwKu8TiXoHapxGLDQ2ALgOIM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM0PR08MB5505.eurprd08.prod.outlook.com
 (2603:10a6:208:18e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 14:19:16 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 14:19:16 +0000
Date: Fri, 7 Nov 2025 14:19:11 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, miko.lenczewski@arm.com,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for
 swpX emulation.
Message-ID: <aQ3/35146HkAqM+I@e129823.arm.com>
References: <20251106094023.1371246-1-yeoreum.yun@arm.com>
 <20251106094023.1371246-10-yeoreum.yun@arm.com>
 <9fffb30d-fc9c-4e2e-94d2-c724e81ae3ac@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fffb30d-fc9c-4e2e-94d2-c724e81ae3ac@app.fastmail.com>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM0PR08MB5505:EE_|DB1PEPF000509FD:EE_|DBAPR08MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaf0a16-aedb-4bbf-58e3-08de1e08b697
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?uV1uItTytOYdbrhcyzi2R1SVwkeKkJy3ePYUQwlB19PetRHrpgRaKJdik38Y?=
 =?us-ascii?Q?HVQ4sFiE2B6e7kqUYuUvzPFRikRmtxhPvfvtQ0LJwy3u4QMU6Er6t0LqJg3A?=
 =?us-ascii?Q?5dBr1U2lXt3CaueXqCX9SfS+Pb0pp+pwxbCWh/VVRK40niXiytXiUl4hufZE?=
 =?us-ascii?Q?2GxhQ4dixa1LgJUyDp/5lehNnbwbOJXHcE11xN4easm91UPCOmJhIGAIpF4h?=
 =?us-ascii?Q?i1ceI2KGtqYBvBYZfnfzcndcOACvPo5cFywLdXbCJi72DSKh9ayOFYvN88l+?=
 =?us-ascii?Q?eGOwIqijHON0N5etOU+KCOdT8ksv2sysCYMCxs6gc/6pcZ2tCKsvnxlUGkux?=
 =?us-ascii?Q?LmoRIvWZbeX1EUYOF/91MVA3fdoT13KCbc4rnHaxf9fvyz0hdKjpuyqhv7h3?=
 =?us-ascii?Q?8+zLNFcrF0czV2r837jtfmB8l4T/UNMc59dV0+7KADOA5tAIyO/37TRyIz6G?=
 =?us-ascii?Q?p6JVe3GvEW+RmVXT7/VjNoANYA9s1ZGvkOJoiDfRNOMUQO3HnZ6Y2732BAW4?=
 =?us-ascii?Q?6ZTuE8mqA+lPorPsVoyht1f/o0LUzpTDfS265sA3cO+Wssj/FSeveikNz2jf?=
 =?us-ascii?Q?yXTsuCgeeAM+YIXQ50AAWZxVgYkieI6VHBQoW65fubh0YGJGo4vX3XmK7IuK?=
 =?us-ascii?Q?2RVPV3TecI3IfZAKiXadAqO1wEvpm53MXLhygLkJf5rMS10WIjs2k8mQUGdb?=
 =?us-ascii?Q?HE5zi0ISqWN3D2Csdc4dHM9rTFHD9+KIK3bOKA5V7RzGljP/kmMEAKxHRckw?=
 =?us-ascii?Q?G7by2xo5b+gf0hDAmFScDBt32a/Kuv2jGE0BNqv092Hl/ST/SXHXO/vVRr2h?=
 =?us-ascii?Q?2roV874KaNyeFTokK8QiXWbS9dFx1Gh9B8axd4FYt42Lawf+mWIl1BOTc8rM?=
 =?us-ascii?Q?m0iJNljpzZ6rJaUmwEgwk9tZDNvd/xQM8iazt2+uSenUkprbJZFGAfktxnY9?=
 =?us-ascii?Q?svdOkI6a0sumbk4RiNWI2M4Ny4j3g+8kPp65KrLZ8JMEhLjK/EoMkIgP5fnB?=
 =?us-ascii?Q?UL2tiE2oIVHNFsQNlyLsNkwsPM542dM2yxvrnNfsbEAwvLEtsSU1b9tNUwje?=
 =?us-ascii?Q?GAWCgkHjkignv+Pz7KcaxAkG2CyOvmI1hPrboSXU6e7zQGUtxeguTdLSFE7X?=
 =?us-ascii?Q?hyQ7RmOcw6wyTQo5skbWiXhKbXCs71DrohRnJ/+Ix3bFJjLH+fg3B6axR/Jb?=
 =?us-ascii?Q?9gWF5B2DKWCmq7hq6LLePEwKB50FB7F8ePmKv6vI3/kVHPS8LuSPYEZyq8RP?=
 =?us-ascii?Q?e7XCrQ0Z4bVxvJEAmge5trAcYSZsk3gHSKwAl9lVECzCvXpPLjzU1VDtUg+n?=
 =?us-ascii?Q?JVtEuk7aiqjxzGnxwJrp3uWAHCTggjd5gFFfWdUjOtA76yYJ+7lknDUp09lb?=
 =?us-ascii?Q?NjjWu5YRDctJ3qjYYjlv76bNEW/JSlRLMuvroLT+exjwFKGRK8UhTM1x2X55?=
 =?us-ascii?Q?/0znflbfPXjggRRzcc/g+988lQH1XWE2?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5505
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7bf0acac-2471-489f-eaaf-08de1e08a1e5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|14060799003|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wgu6XWkQBfpj/wlhbT0nBLU1pClc32ByMk8WJI7xq4T+c7OhQfqjkog/2qk5?=
 =?us-ascii?Q?rEhT1FQCHpXpweuUb3ck1JrOmCeC3kdOQCbg84g+He6Bo8ff6DUe0mmE1z7K?=
 =?us-ascii?Q?AefstuEs2vu+ZTs9/O9vDfgm4aJ67Uiv0MQb6WCUPdIHdIPzuQRWIXtYE+dy?=
 =?us-ascii?Q?EEbRdVcE4uQTmVAwxXlRmWbBgn1hbnWUT8OtwQCrNYVSjMu8ABnpJBzMhbcZ?=
 =?us-ascii?Q?zI56OQM6FWa4a3Rh7+Wv62XAxx/albIbiRPdwDPiIsns6c0wuqgUmkXIgBNa?=
 =?us-ascii?Q?jRCPIB1vmQjre1MHn1UC9OREB5AGrJrwkiBNa8RMHcbGcHaaT/Yi6cLAsnaU?=
 =?us-ascii?Q?ERACH6PjApIPrv/xfkSbq9VIXhwLgUh3K1KteAX3aIOgdsKGPnvExqQhkLdS?=
 =?us-ascii?Q?obOyvYQX83teS38fr8jTsR1+8txIOHRRUAyTYn5zyWdTYViHYLfO2RgNVBmd?=
 =?us-ascii?Q?BassFw0/lDXtGZxyCWIBADtjIWlMdux3TuLzvoeKYoJNtW/ncyeTCXJ1Jz5q?=
 =?us-ascii?Q?4R3uc4asrbSuZ2zH0kb6ttszfWC18CC/OgxtvOvx7DgWAS6VJ0rNrc7FT1ki?=
 =?us-ascii?Q?8yTCBUiRZ/9r4Mg17p5/G1r7GNyTSeFCCPsong7sK1381tZOIGBE7UAeHT19?=
 =?us-ascii?Q?MDUiojIwfJedsfla6jNsH4hIXleh8HhwPKIuzWgy8lRNxWpoB63QD1qM8jpo?=
 =?us-ascii?Q?61cL5VqVw91b1HH8xb2ltYapbwTKky92A9L+qkVKJ8Hrx8YmJ66zVRqwtI06?=
 =?us-ascii?Q?+WfbRq0bmoEoXG/ymfLKqaS+G+i/uYg5UmbQoirsfsqggg4x10lAoRFQjIUH?=
 =?us-ascii?Q?47sCu1CLrc08uVwoPKIny9DkX81/AWynpZT8O5Qn/M+SDRTKaDSZFuV1Q/UB?=
 =?us-ascii?Q?1LM7Rbquf2SPPTvNRv3P525UoywYhudGsxYC1vsTYd2IRPxbFn2IiRjgbrGz?=
 =?us-ascii?Q?F/mdYDQSi4dwOCi1J+4WAwp/d1Eb/wJmKUhKCeBAoEBCOm7dnyfwqBMs1yCD?=
 =?us-ascii?Q?1ZtuEIr2HjRjxiZPjPLXLmZEWnCAz3YbFyzow7l9MO7k4d0PPxoitaLFxz5+?=
 =?us-ascii?Q?mHtdRCGHBiVVDRwxbheWK/GDbz7MT6Tjky1mX7ofVxG7bj/QJo1zEKKLPmPz?=
 =?us-ascii?Q?2AjextSIR3CTL9L/nv45c4PZ4Ob2JVaWWwhl+ztTEQikcTHtLcQAflBJnqkT?=
 =?us-ascii?Q?enuMTOBKEWQJQ+I6S96RDtHR8duGQBaGuBowZSeZSvhbb3Vy/MquWea90sGM?=
 =?us-ascii?Q?odfPIxVQx/LVCTrejxS6cVk3ZmvvqrZrjTuFPaT1ZQtuaBlciNksWYc8dVPf?=
 =?us-ascii?Q?orPaGFrSdknkKVFV/O9s0kEopVtM3aNY7SsFHnhmez5KfZ1tvzpk0ZpDzkFA?=
 =?us-ascii?Q?Jp4X5ViCryUkmDD8+Gza9V+5LSJhbV9vEA5SrizuRLQWr/3sE/fMmxcf3y9d?=
 =?us-ascii?Q?wN6Z2rGrn2+ogXld+SX1lWaANfjadA5sxtZFZISb8kEOP5G1xJWl/bRG8JKd?=
 =?us-ascii?Q?yHpHhuePCkNMEfXYYLoKMq40P+DkShpq76xNz5tyWq55SZPFIBVU2UH4+jUr?=
 =?us-ascii?Q?LNaspMi5+9MzbA1+7yw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(14060799003)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:19:50.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaf0a16-aedb-4bbf-58e3-08de1e08b697
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5656

Hi Arnd.

> On Thu, Nov 6, 2025, at 10:40, Yeoreum Yun wrote:
> > apply FEAT_LSUI instruction to emulate deprecated swpX instruction.
>
> Can you explain in the changrelog why you do this?
>
> In particular, is this a performance optimization or is this required
> for correctness in some scenario?

I think the main purpose using for this is to "remove the toggling the
PSTATE.PAN" bit. so that remove some *potential* problem which can
happen when PAN bit is cleared.

also, though swpb might add some complexity, but swp can get
a little bit of benifit by removing the ll/sc way and reduce
the amount of instructions.

> I would have expected that there is very little benefit in
> changing the swp/swpb emulation here if the existing code
> has to remain compiled into the kernel and the overhead of
> the trap is so much larger than the uaccess_enable_privileged()
> overhead.

Yeap. since the *trap* overhead is much larger than the
uaccess_enable_privileged() in the performnace perspecitve,
It would has a little effect. However, as I mention above,
the main purpose of this is to remove toggling the PSTATE.PAN
if possible. there would be a little bit of additional commplexity
for swpb but it seems affordable.

Thanks.

[...]

--
Sincerely,
Yeoreum Yun

