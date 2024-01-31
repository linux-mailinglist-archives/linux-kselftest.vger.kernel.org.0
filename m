Return-Path: <linux-kselftest+bounces-3845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740E844174
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1716B2BF5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77680C0E;
	Wed, 31 Jan 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRMA6s3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC679DA0;
	Wed, 31 Jan 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710201; cv=fail; b=okHcUsi3MBDf2+qsYnQjTPti3GCjH6AIb6PAWL7eCOeulMnySoS1WM6KKljN8P9QD8lO3fVr2aodLSRvypEVmn1K8FZQnTnosP+72gpgUNzVDXdky4R1/lpTMGrHfAhXODQi5dTJZpUh5HlmTdMpKuNf343juvlknSPd7CToJ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710201; c=relaxed/simple;
	bh=YRPjQjOjJNNAlzkwrzq21VgU17fCIijHiiKcw2icF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AvRtdyKfFIXsW6hCTCBnUqK+oVP1nO1namaXpLIAgwR1w8yZ6JzYYvYlkwM3GUqyvWJeNsiIK8ftXoMB5U+SC02C4Tmu56R7012YLt97/jr0hPelXYRrPTg7n5Wljl5tiXfWgbdI24Tpmp4ROKRGYz1W6BTws7o/iGz+B+9REMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRMA6s3V; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4UuaPVExLh/V1MCCY+QthGSco05SvpjlXYsqgKGvG3OTUp0ht5JoOoeucIbXhYk0xR5zDaI1ZikwVP+2AO90kzB1pEYEppjG5mn1S9W8f/FG13zMP4zNWyUuVJKVqMVmLPO8mSalbUG1eihjyUWvoZawj9hKo0nzST0iejYpynj01sR+82x/Eoy4PNAkGtT76sxVdlQ31A3uU21mMemlsP0KJ48U7fQwWqXvgFNcZwX6HN3kE+vP3DxXNrCaFMuUXYE7hSV90VvTng21PE3uE+fDI3DW9f5BdAwbDjJLAZa/wHGIcVqDfh0VITVLhfJe9D7uYLK4EAXTy8TFuNFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njXNdFYB3BTHHBy+vbOUzniFgpw7xC05k0PmnaSGmxE=;
 b=gb/6YX84960WciKiVX6UhOjfyCG76n9FeDA83AHxEf/CJ6PODOESixZjMzq/n7pKkVxc3Hea1L68XVGDxL8BsZ4Rv5HKWPCZoZrT73E9WLTde6VwqyX6GUwcnMEqyW/Jp2e0P2ZmFeCPTn3EFwvzdi8RRcaJTCJHsfcLvX18phh1IakxXIIfI/qNuDBZLlAr5JD6MufA4F+q+xkmJfiw0CUOwqP2OyivV0oYpINY9hzmJI79qzVflkzhXHFOdO+41M3HQ/k6jOM3qGwgiOHU3ErVfG5Ic/rtGS+gRZRXRkxeNaq1cG8lOAjuiGL8GKopENiYJpidNTx+0tf7T5PTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njXNdFYB3BTHHBy+vbOUzniFgpw7xC05k0PmnaSGmxE=;
 b=mRMA6s3Vu/K2MaI9fC5zyXsI37MsjlP3AMeBUK7r0pA/SeUkDBZsS5cIB0IOkDNCZvpqpmifEn2ySQQz9zyDxUFZRR3K5OMao0pqzdSa6fkVNJTZ/n6rDnUAUmNE3KhX8ShcENViLrS/tS6MQjG7FQn4vkOcwvLOcVJpfsXytFXdyxsa51udGdKWbipInYTLSmiff8uomsFAR0eAz/oWfkBaNrnqwBSM9XTv4kZHTIoxQsF/3Gcv5d//q/3GfAcPv0PfrV6qVEGAGQ4kH+Qg7Ke3AKA2LbuLAWPAvSAML9tfycOYLTFbqt+dm/EvVVF6sg7XqeoMmnGYkv1gG4iLZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:09:55 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:09:55 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Coco Li <lixiaoyan@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/5] selftests: net: More small fixes
Date: Wed, 31 Jan 2024 09:08:43 -0500
Message-ID: <20240131140848.360618-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::10) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5256e705-ef07-49ee-e4a0-08dc22664d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	741UEURPFqZDfcb1nNFHitaC8enhtEnqWKCA2uMB9WVEuxENcfkFExfxqalPeJ/KKgNKcgZf0DqSrwm/H0PkR7yoXC3JtrV5155S/bU9yHPXDjJOXBlC1QkPj/S4yo6Wa/741UfcvPnBY4logYaguYhqm/JVRHW3zvh+IWOR9Bwqt8MDSIHfxP4KrxfEZnyJ+yVGxsyVFgqDPkC+GLJ+EtzkhgRhmPjhSFmx4l9WSUt2AbuVLYubewbG20Mo0wQvlsrTa9SFU3xTGN1c0dqdczi35fAoyOQ825mykqnuq3Xj8G/bMww6gfSA04Iw0V3khRaHJZvfmZhL8FUpSGuq+e9umYefYv859Z9bxlLZhY9Pd51B2SQjIHaI8yFSGKRZR1v2sYV5TiCWyrQV2sSOZTpXgCFXW6xqeF7ozcjtmLftC0oD2dMk016iUa6Rfi0prZbkHu8APBbwh/ZIKVIKJ2ZSK6gi568lKR9rZYen155+LLjMRR+UlHiQVi5ATB1eyMLYT2s0sIqKzVY4SNKtTL++ivb2CNDuDi7lQvmMh3pOlXXL2T0ALM78aZ+ICd47
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MCtsmQBBowgAMknMJivwcj+b2gkOmJwQ43D7XvsB+Mrei5sOe8XMa3KIdZ3y?=
 =?us-ascii?Q?J4ECuOyKmiq4kE/Bg7j8YeClELKXX+6gnMUrou2UirWon+s027FUDozlZa1D?=
 =?us-ascii?Q?iFKSc45CxzU9T6Zxd041ItEyNxTFu5G+J4kNVT/fJPRptzGldgFSczYM19/9?=
 =?us-ascii?Q?pYidXzE8DAp/dWzuGwzLSX8UiZb6fLfP8iL2m7yAUFifZuqwPHqB5qgQvTPG?=
 =?us-ascii?Q?USRgXoyarniqmf4QW5z+go2ADWhBc+tyzDkIOcadFKcJt9r/2RF1omkrwWSF?=
 =?us-ascii?Q?QvzBJuyIluSvGFAkwma8FPX6JWo+NjPY4F9oMAPgVDEJfneM80gPuF+0S9Ft?=
 =?us-ascii?Q?KJt6uZtcqV8CDjXlUqXBaMzbt4sRolORbS7DJXl4gIG4EowQKcI29xm2YE61?=
 =?us-ascii?Q?XWSmiq92fxPVKzS4z37OmF/MzKsy5CxlSfjdydn7XTbYFaH2PofL6zKXw7Z+?=
 =?us-ascii?Q?wx219gleCHqjd2PMocl6SFfPDpH2clPi/F2oWN4I2GrejXLyHzEReA6NKqgE?=
 =?us-ascii?Q?HcuzUo/6/n/AwO5Zx9g9r8qxo1ealoX8nivT+RwiscXsh2e8IDM4h4drAMvo?=
 =?us-ascii?Q?+bZD02pG/DJ7elzAt+GvKUillHF3kY17bgI/m8IpFHb3iwPZY3MbAQDsjgYZ?=
 =?us-ascii?Q?LJKEjk20sYG8YPxvQTT0Ocu7eyEG0uun0WnFFR9OioTZIWkSJ6hQ7vCuUmLU?=
 =?us-ascii?Q?x5h9ce8NpuHE5T5lzXz2Sa+LXaKRtkmS4E1B90cEZUK/9PKZKZmX9rjtvp4Z?=
 =?us-ascii?Q?LMBDRgxEpOv0M+eqVAfu1I+rgyXcs36MUKsq5IYjDxX5hCw5TKo5M7elmhoE?=
 =?us-ascii?Q?Awxlg3oDXMKDMUcphOi0XBVjvp9Cw3elvKKnzpSp5KNewjHka6Xsi/QlXcFD?=
 =?us-ascii?Q?L8x0yN8OitPUoga9Pb2nEyOXNNNH8ZZ5KBkXPoW4MjnjHXn5yn6IrqyrvguM?=
 =?us-ascii?Q?IRMN71yeP6S9Mvld/M3CPiC4hWuq7UIqhFTkPTpH8okEOMTC4MvsLV5ellzL?=
 =?us-ascii?Q?MCdAwnzg1LaJcCxPDUI9zE/NmPHdN5v8Af1ysdOEqRL8dbsI0J/tz0Oay7SX?=
 =?us-ascii?Q?3fomFz5T1xbMknjvwth2HCOHC59CtesAQcV59fzKa3ldR6HqdlVSLCRShhNC?=
 =?us-ascii?Q?MtibYCWEKxmMYZf3IsmBU7opdhCr0yCne9nxJIIqWpAKXjr3xsSDCAniswmY?=
 =?us-ascii?Q?aLtGzO+U47nYlQ+EHc+j7Hbnm0yuoeTvMdvj6Mhf4k9dEh8ZhwQj4Xq6nki4?=
 =?us-ascii?Q?LX4C99jdQuT3A6F41hUzK27D9o+HC1dzi3Vzgf/Uw4oImKMwAG2gMwW3TPm2?=
 =?us-ascii?Q?5olNsh221Hpmg2EUjSjs/sB51rY5HyN5lwKRTvYLUIHKvK5lXPC0bIGwKEiK?=
 =?us-ascii?Q?tb/7oxxdENMqXlYfaSKintDcI5Wrs7euXmFUGIfZJwBWd3gc18h09BL89zhu?=
 =?us-ascii?Q?tZTt96RZ9n8JJQYbwQOg7LHqlApn69Yr6r4+N3hJC+R7nJ7+Lq6L0aVLKPiY?=
 =?us-ascii?Q?MT0EVbt8wu07FfEp7PgOkU5kQhFsvPkX68d+sNHvPnd2aQuZiOlLYZc3oEvk?=
 =?us-ascii?Q?eigFFlP2JVm+byFDZaczzyv2JGfQcwTyNZfZ3aGo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5256e705-ef07-49ee-e4a0-08dc22664d02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:09:55.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHTNVwsapkwDc4MTiqkAiC26B2TCRT+v+t9HoVC+nQt6a6SpbMC4ODVcTT8CCSIaDgWWbM6kpxn0HUXv0SXvpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Some small fixes for net selftests which follow from these recent commits:
dd2d40acdbb2 ("selftests: bonding: Add more missing config options")
49078c1b80b6 ("selftests: forwarding: Remove executable bits from lib.sh")

Benjamin Poirier (5):
  selftests: team: Add missing config options
  selftests: bonding: Check initial state
  selftests: net: Remove executable bits from library scripts
  selftests: net: List helper scripts in TEST_FILES Makefile variable
  selftests: forwarding: List helper scripts in TEST_FILES Makefile
    variable

 .../testing/selftests/drivers/net/bonding/lag_lib.sh  | 11 +++++++++++
 tools/testing/selftests/drivers/net/team/config       |  4 +++-
 tools/testing/selftests/net/Makefile                  |  5 ++---
 tools/testing/selftests/net/forwarding/Makefile       |  2 +-
 tools/testing/selftests/net/net_helper.sh             |  0
 tools/testing/selftests/net/setup_loopback.sh         |  0
 6 files changed, 17 insertions(+), 5 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/net_helper.sh
 mode change 100755 => 100644 tools/testing/selftests/net/setup_loopback.sh

-- 
2.43.0


