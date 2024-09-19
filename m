Return-Path: <linux-kselftest+bounces-18136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4063D97CB32
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BF01F22090
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BB19F49D;
	Thu, 19 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ii4TYruJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A61EA85;
	Thu, 19 Sep 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757772; cv=fail; b=jYmaHiaHmGXThpYxlTJQkiM64Oujaxf2IqvzkkLh13OaVrQVMQT54gpq/6cokEG4GNWNJnCdOa1MWrQmoD2nx+9Ga6BZikE65KOAP+S1PWGuo78xGw5XttZLv1TevGBGhABsrYr3b+6ByrcbjBxRUaNm4xzOsdiRuQDZ7/rcAis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757772; c=relaxed/simple;
	bh=oHEPRtsClnGKIiIRMaYMsiJG54y5GOshYUJ2l9kvUg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vy0lFSDdd2ApwU579WiZ74P32vMdzS9WPfJijJUnPJGQOMqB1a4ba/QCsg8mt6f+fytG/XppXWuMkchEh6vAod4Hv2CDRLvrceIYBsRq5NxSPvt0KKlWD2oAJxtddufZrNP6bjSZ4C/H5XsS6ktPy0DIAG3RPqtW622u75voGTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ii4TYruJ; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTNqQA6i9IEAtesksV7PAQPHeXiw2FGiYi+7ltESGs5xQyJlYse+lnSjKRmShJGwyzqllktBEZ+0j/7ZwWzpTIoGaINr3YdITEXwzAFQoADhmunASUwnb9MneZsHBdqhjra2KkcxncpNvYXOVXSlSIqykIYkx+oHhvxjkhgBtzMccFAH+0G+BtP3j5mT7X0y0r8KJBl/QNOH9HgxH7VpGYeyXoXVwv6hy2/FH8vefUBomODW09AAxCcaU0qSPsyTvY3B1kPZRDTexMtrIsi3dYdfxiSvlBdux7nzJMNY02cdN7Ob0WXDx8IPX+8y2JMT02hzgKhBCjtIQywbSkzdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l4+wXQgwzqGKTNSqs9zWZIFka18Fe5xHWD7AK04KPk=;
 b=XyjizJzHWVHFf0ByF/jq130ScS1J/yukIVRykZ6tkoFuNBqZl21w+r9uWUlN1PwiemkGh5NlPIuDr3Thv4A8sU1Gwm+Ag+jrRll1PkNJEkkVwfpV6iY5kDHEm8VdSgQFzOmiQ8hfhNKV+IZ2YDFk71kK+mseNS4kFEaBE5HEaSoWW84qjT2PbF/JCDbPoA02v/MTg4zQ7ASbbmbQcwW75svzOES9yYmH249Dcyr3qo3MEWtLSTf3T8DAbxZ2PAkMNHGVNBng11xlkVpt49H+dOAz8fmkR0q+Gc/gAt648exj1YUzxZdU0L6oFAeBOzpY/ojNpNf2w4jzrppa8j8TIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l4+wXQgwzqGKTNSqs9zWZIFka18Fe5xHWD7AK04KPk=;
 b=Ii4TYruJAFm3JeZNmlkxSsPQ1lPiL1P9cQGUAp1iXbKziQ/nU24AlDAuwEu8cR7CtivmytnOYbHtmQknljqIpNNDB5is2G47ILZni5f7dtKiWW0VqOEgtpiOCHe/DFbul9z7RaVx4xQl1kSq8FG9uOPCrfXcPs1haK78S/U72ijTEImG6jcVHzB54F3CVAWQpL748gi7kt1O99SjxHYi1A8hmioHRJBMB5It3RKZKLeWJFHbAjByCGDQ0Joj08KZ3+XSKkb2Ocx16UMjLZz2ho4CSoAKAnRbzemfEyw6HxF+K71B+W9KwieKsU2WpoI09Eh0PUUd0+mCPgidW7LBng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Thu, 19 Sep
 2024 14:56:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 14:56:04 +0000
Date: Thu, 19 Sep 2024 17:55:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: forwarding: Avoid false MDB
 delete/flush failures
Message-ID: <Zuw7d9eRGo4wdVP3@shredder.mtl.com>
References: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f3b510-b959-4ea1-9da7-08dcd8bb2f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REAaWeDkD9UIWRhctx2Z52V0nDZtPBNBETVK1od0goGVTmXb/Rg04ZzIdAWC?=
 =?us-ascii?Q?8hE5BOMXfJx2ZKs1iK6X6cvTbH7G4kfGL/ozTVkz4ggh/pSeST2l/BlkkRoN?=
 =?us-ascii?Q?TWmBxZQxxOpLop03qN7Vh5C12WqmLR9QM/uDNZrmlTGt4E+QHfMGsbLmx5FO?=
 =?us-ascii?Q?Lch01OoXzD/qxQcvoT8DNH+vUFuz5Imbu5Rq+cLCSACyudDLXopn6i/O9ee3?=
 =?us-ascii?Q?Vd59O0Wyx13gQK/nzZa7mjq04YNhlNO9BytDpVTTL3lzEEnnvgznd/Nvx1C6?=
 =?us-ascii?Q?qyXKkUXD9tQaFAWS3LVrTl9OYeXvNTXN2ubFhRb+5o0eBuLtaVbl3uQ+WrD8?=
 =?us-ascii?Q?Gb/8e+6Iw87v8AuovIXoV0FymIh/OzcAxkshqhVxgC+7skdQLLzz8ZGOuUnU?=
 =?us-ascii?Q?gKhNSssAKMi9wdFFZ/kj/9LqDgRy96ykJiXeeuDjM020AsUoVYklbmHHnWnK?=
 =?us-ascii?Q?nDZ3tzMFmoxkkwjjqQD7RUhhXSlIaB7/LqrU8mk66w0r8hAp1RG8gGi03+XJ?=
 =?us-ascii?Q?Wy4IwbkOEukSEgs7XZ2rCVlkOMT5hbDwyqIyMIL7qBkXnD6XyqsD0z/K6aFq?=
 =?us-ascii?Q?wrSkujvbnd5P4z4nXPE68ZKI7IoG44AMYE3Qsnrbb1uyzHkO3TCEk9ghymUS?=
 =?us-ascii?Q?66yHM2nz3hvoy66qhBdzZ7vlKvXWnO/H1PGwD66dgBQBilmgwM8WqkKCkJDz?=
 =?us-ascii?Q?lJJgKItFoDTv6XvpBLSkF+hJ3O/KSKxRRbD+2Q6kM4ZSCuSX+gvYfO8g0nuq?=
 =?us-ascii?Q?ZJMTy78RnFTgjjFRYegjcZpPj7geR3h4DRzOYMilralIvWGNPSs2glitaS44?=
 =?us-ascii?Q?C6mS9xZUdlsgaN8eRYqkpbRam3ycBKRUpncpyoMoVV6M3n/B157uVC0UvGpG?=
 =?us-ascii?Q?pHnwrr8YgWHTCnJoPTrpJ//J0tN2rKS/G9Ro/FvMcnwWNTXdyi9Z5350Pktn?=
 =?us-ascii?Q?sg0QBZq8UyipKUxdJOSb/ckkIYsp/wNFUZu4Vc5UBKb7USf6QyjtfIAyTurD?=
 =?us-ascii?Q?451b34LtNRU0lbTFbiReMLBW5xyOOHdQLwIoUTxd/7WMawZi5RO9XeW1tfNK?=
 =?us-ascii?Q?b0PfkWyuExnKub70ZXuZp7dp52Y7U20zJ9aRdw/TQGD8AB9V6USJOjwopn/O?=
 =?us-ascii?Q?AEj6k1ewgXE99vbPF+A1aMVqnVa5bYtcPZJANnmXGpQgFM+NZsRr8eV6d4Op?=
 =?us-ascii?Q?33pWYyS6KfESYdRQvEe2mEOQAoWLdoHjKbCBl+b3LWtpP+sC6zrrpboP1bVi?=
 =?us-ascii?Q?2t3OVJScErgw6M/gAXokQSBkcer/qFBI1XJWLEXzZ/tSKiBxbxccUXl5vQUN?=
 =?us-ascii?Q?eJPjDUE2rKG4rTB1qeqzPqD3tHUYCfyMNcjmQ+mIIlUIcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hwkMXGHzmOpB07yaJPlSez/H+0OkrEhDi0D7AgnFBxUsDl52RIvr0YJiC+p?=
 =?us-ascii?Q?ag6ri7i04R6+3a0YpXCCtg53RAO1ozC9Tz9Ebaj4FQzPHoADgI9s86ubFjX8?=
 =?us-ascii?Q?3l+2PY+IRywWYeNvDzVLBtfUJSFnMIfssqDJk74FIyuA1EcXwSJMEcfE2Q/R?=
 =?us-ascii?Q?wDXaLEp8sMdux8SmOQlHlcLHVjcDt3TRHpUZFi96xFbLTePWGE3UiFKs+Sdh?=
 =?us-ascii?Q?i3W+Q7wLmqYf+QUxNaZAt19z2w6ovlpFfe2WzvPvGDyLzB0wNEOSegePCgXK?=
 =?us-ascii?Q?xX49de+y0Pc4v/WSgOPuBNkGoTtcK3obqBGNGe9+iuNCsJRU4D3VEMeiiAJ2?=
 =?us-ascii?Q?Fv05GRxaMvlsummF2GEdgWzypamJdGYyx6CuhVGFk2hVyYSkSFQvPdKZmTNV?=
 =?us-ascii?Q?N9/eYSmSZ6n9aUgALx5o8XpKcl18L+lsdM8CA6462PuBPUMJ+OVPPxIfM5CT?=
 =?us-ascii?Q?IHbQQvH+M7Pj8p8wntE/Fu1pzShqbW7ZItplsSgk+fMJElrVQGlkgI5H39LV?=
 =?us-ascii?Q?J9tBArI+beP4BOmuhyO2ouOf1l7ChDa3Tipo1twVBcGHtSlE55Zag59iAteO?=
 =?us-ascii?Q?1k2HxgtSev0LgeWW1ztf3DqTdT4tQxcXAjh/lF5ukul6qIltyRn818iT2xvS?=
 =?us-ascii?Q?MeUHMJ3GtXks6U2cXwyRZZvjIEwZpo3gJveEoFUxdov0D6N2KlzskqWgiqyY?=
 =?us-ascii?Q?4UAgwTXmMPGTMu3EQiNLYivC3kAcIBO6XdireGH2sgJr2c1PxQyZof57z4Lz?=
 =?us-ascii?Q?yRqpJi41OUDY8MbY5ylXC+UrQrbazJ28+YyBWo8Mtq/pCCQC8dmmpDuDl6OD?=
 =?us-ascii?Q?kITR3Fj8lMAXKHfCXhzCd7gN4eO5gVO1pk6KQnvAZHcm/gpKW23te1YOHNKT?=
 =?us-ascii?Q?bBOQt+CYQBPnNDY1WbwUS1BKIoZwaw/iZ6ks7vJmv1UtJAGRefozQaQdTHIA?=
 =?us-ascii?Q?aLlVwnq758rsP3t5EksWd3Zz7dE9TtqH/cc/uMVmJ+44ylgk+to+i78l+aOE?=
 =?us-ascii?Q?vHB7MSyhpBbqsl5UAAUjur2/iFIx0ZV6pIKY3giirvcmEG00C+l+1f3cqExn?=
 =?us-ascii?Q?5Ey6se8m/PAQLOKlZm8xGszOKNkesIUarJQjB7gBS4PoWEXlwWX6HL8xvE25?=
 =?us-ascii?Q?TV3HI1Chpq/83nK6J3fYV2MrcK7ZeGwa7y1+9HO+klx6o93ZfvmnzLJEB/SR?=
 =?us-ascii?Q?ArbpghXX7DpA7Y8iyNejReANZuZ1yGFX2wVs91Gqcjk4gNfpHDZkbai39E2r?=
 =?us-ascii?Q?ZTLvBTjSTo707qUBYJYw09pXaC3wqkA8CvgI9xQkSI4IMbPNYoJeZDUUpXH4?=
 =?us-ascii?Q?XFQK5ugqyv8sVLmE8/jqPTVzfLDRibabFlNM5ELM3SlEnyURB5nNuVQArqz7?=
 =?us-ascii?Q?c68VWJo07ZLnCyASaK/nzMFMd0vYwnfV/wEEWSKwnMNaiGvfziQq+xrufaoZ?=
 =?us-ascii?Q?pI1vBu23+5Q0tnxfj8hqaHBNg/Vw4mpsBqO4VjKH6DUvOh36pUNwGLf//uHE?=
 =?us-ascii?Q?0/Teae7Zv4WKTlMaOTOikNW8d5bOjIZ7AH+ddP3z0H1j4dJi89P0JPSmF6Hk?=
 =?us-ascii?Q?++15hgaZ4iGrK462u4nsF7c7mzhv2C10U8RaRPL4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f3b510-b959-4ea1-9da7-08dcd8bb2f3f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:56:04.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZOsuwMLuSlA/9G6Mw6losD+4mlRHzJkSjwQWX8KAsa0ZYpcn2YwvWxqWIgkClGpdm3MnJxrNhcGFq2sBz6mVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

Hi,

Thanks for the patch and sorry for the late reply (was OOO).

On Mon, Sep 16, 2024 at 07:49:05PM +1000, Jamie Bainbridge wrote:
> Running this test on a small system produces different failures every
> test checking deletions, and some flushes. From different test runs:
> 
> TEST: Common host entries configuration tests (L2)                [FAIL]
>   Failed to delete L2 host entry
> 
> TEST: Common port group entries configuration tests (IPv4 (S, G)) [FAIL]
>   IPv4 (S, G) entry with VLAN 10 not deleted when VLAN was not specified
> 
> TEST: Common port group entries configuration tests (IPv6 (*, G)) [FAIL]
>   IPv6 (*, G) entry with VLAN 10 not deleted when VLAN was not specified
> 
> TEST: Flush tests                                                 [FAIL]
>   Entry not flushed by specified VLAN ID
> 
> TEST: Flush tests                                                 [FAIL]
>   IPv6 host entry not flushed by "nopermanent" state
> 
> Add a short sleep after deletion and flush to resolve this.

The port group entry is removed from MDB entry's list synchronously, but
the MDB entry itself is removed from the hash table asynchronously and
the MDB get query will only return an error if an entry was not found
there.

IOW, I think that when you do get a response after deletion, the entry
you get is empty.

Can you please test the following patch [1] (w/o yours, obviously)?

[1]
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bc37e47ad829..1a52a0bca086 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
        spin_lock_bh(&br->multicast_lock);
 
        mp = br_mdb_ip_get(br, &group);
-       if (!mp) {
+       if (!mp || (!mp->ports && !mp->host_joined)) {
                NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
                err = -ENOENT;
                goto unlock;

