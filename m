Return-Path: <linux-kselftest+bounces-1282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1680700E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1051C20DE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88A28E23;
	Wed,  6 Dec 2023 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HELuf6ZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6A11F;
	Wed,  6 Dec 2023 04:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrlmqHLijaZG7lY3t/3DDPBPMNDqXBBXYUu+9wbXoz/2qh9LTpF9Er5iS70bKK9s8n3AEU4JssuLDH2fSXC0xvKGyBWh4euXTz8J7i3qERYc0IRNR/E0w9TrhKvJAEpfjtWmiOYDD2DqRsTTDEHQp7FgdLAz2oMDnIDX0tWHWGPpb4tsNxGb2HGkDLpMb7255bOcm3pivHPM4FRwRvZLyLhRlLz8CLjlyLm+6Bo7wgcAx+v9C6WyaEvx7Z2N+IOlkeXtF2yQwQT5hJPe6X+yN/614b9ybZZX6j50lCSEst2koh+cN9jLAi2CTAeXk8X/m+D1g9dvyaOSidU2fKggIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hiNwnKlSPrFyPes77j5vPOrtYLTcO0PNdwO/JogPYI=;
 b=KUJd2Uu9uo/rJjhGgLr9XQIuYtF4jAAgyiXEhn2nkqBJNKRjlAYM8SLOAk6Fqa80I9xCAECEuqjlYZ1Jp/LIAbmGiNgdMPLJA/ZdGktdXy+3YMHpsQqBKlMNjsmKAdsIxdH4vXDk/C5xO0Kr+Ec/XtNYPZ6cQzDY0GJ8Cw1ZkPUocg3qK+7pbyC2DsLk5PJMygy5qJM8ZxfjZkVqOwNiSIdwb0Yb5SRp4GtzQeazSFlWiIPUQkLs7+ZAIl7IzdaV7ckN9BiD+smBP0zvL8CT9ujA9u4HbAYjW5deB38DTYP94wnDTVtlYq5Sxu0NQ+V4WdSUTA6JAjx8hfoADRGugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hiNwnKlSPrFyPes77j5vPOrtYLTcO0PNdwO/JogPYI=;
 b=HELuf6ZEhtcx0mtiLNxOI2Bxkd95NfGHCLQP/J8QIUvRd0fUyQWvnXLCCm81jkULlbRTvfWHMUPKb3jPLKcnSFZBACJR0Z3Fd7MggwLtMBqG/hsHUzPreBK5dZ/LlEiJSzMdbU0fXZRuSHUwf3weUhBK1Ij9snE9Uy5UwfDRQjnoC/w2gFLbby3Hmglp6KOXqx6DxYppIlm/ztyHsssr6I2zDdwlMO/G9ZZLVR2rBF9+hJS4yyZhMdNBKIIeevXE5xdrL3Ie4tMx2znk3vnLwd6sMI55+gKw5cH8A0x3KGsAIBx54l61qCzKVxlMPwG5xzkpnKL07aOpR8stwb5KiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 12:44:46 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 12:44:46 +0000
Date: Wed, 6 Dec 2023 14:44:43 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net-next 2/9] selftests/net: convert
 test_bridge_neigh_suppress.sh to run it in unique namespace
Message-ID: <ZXBsu7gSlFi7CsYT@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-3-liuhangbin@gmail.com>
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: e697c98c-9947-4b5c-a353-08dbf65920b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YH2Y+36hwqD4eOt7GjZ8szP0feBmB8aLoJT+ZBGHabHijmYGYzOcTB9YoylK4BIj9WA9UnYMxaZ98mZjpPbePFZ8CIz0hit5YIdQTYIBg2Zy6WD3hYFaJgVPZd+hpOtbzcpvskwwuSf/VIZb66IiSNyZO4WWPdYmKKpsAjRk7UisurS4j6aZBhi2AqPgnJBmCJ5C0D0twum5IyxgDXZj9l6eaLrTgjotv8ZcV9nEn021h2Ug9pL5yYIYN0Y/wHZeFQQFJDPtXeXL0TPZ8n4wCKsGY6t2mn0WKN2yPEpT3vU0K+LOrBbMz3p/1EzT2GrkTCaX9UEyNRmdLoqheZg56l4jck9ukW6TkmmCjvw3ow9VyoYJ/v6mKacfRQsTT5OEqqYYNURwIzqyOs+w3xII9U8f3RrPkEd4j2jRA7yN9fl91kqk5GQKMSgzzoyTUsjM0x23FwjPMH3QHTF+1fKdoboGHucyC5KwlzQjlcJdscoUim+rn8PqsqKYwUML/QeNMwgaEocZc5bKYtu9rDpSJkdozFgIvXhhXoy9J3VPOlNJIBc3586J05OmEtCwUJQ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(6486002)(107886003)(6666004)(2906002)(478600001)(8936002)(4744005)(5660300002)(54906003)(4326008)(8676002)(9686003)(6512007)(316002)(26005)(41300700001)(7416002)(86362001)(6916009)(66946007)(66476007)(33716001)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TVu/x/nuCuOPagv+qAdXm41AkbzMuDRt4Ypi9qetH1JnAFvU55Qr7G9261Gm?=
 =?us-ascii?Q?Nq0MNEBWuWnAsCg6D1elM34zSjtNGJ1J4m+B1KyaXOvgqeHp+5m39/LAwchg?=
 =?us-ascii?Q?E6+18LkEGCBttpkKbLpZj4+SVRM+gRRO1111LvExvkfR5bawPEj8wzZl9Zc9?=
 =?us-ascii?Q?PsTI5fMhTfCumx3Eh8VcdokrHgGN3q0IgFE5G5P7aOWeYO5VT5wgjx7dZFVi?=
 =?us-ascii?Q?wJJUF5JWh/efh1NqHXzgs8916CE725fzzu5ZQ6Q8RAajcNeJyABEUpjQvyUE?=
 =?us-ascii?Q?mUXHDGXO5R7cknZm6W/LVUnp4FHqWI4p4k2ZRT66yhYrTBLw9pCTBBsB+unp?=
 =?us-ascii?Q?HWN6XAlhWx5kSIPbXbEzsjuqlnoxR3WXIYsVGillCyEJktWrhiupRwcePLCq?=
 =?us-ascii?Q?WrxZq33yQ2GaKvHkrk88OhaMmMW7isvR68DEmIjXFAVGSume43Hf92FBLg45?=
 =?us-ascii?Q?tN1nohX3Y0S5nhlWRUBCRCjto/XrhfKKkwXZnmCzRERAduhuwQ+OvPBvlPjd?=
 =?us-ascii?Q?r/3iJ3613rTd3y3nEzO9ad2iNR6gtk8vsdyNBqKSbnu2UXHFnMSCDmrIi5FX?=
 =?us-ascii?Q?mgnB3Pw32YeUXK5iaqkcQDffsB9VTSyJW+U+0q4Ka3GnALJnSLkifY7NEU6S?=
 =?us-ascii?Q?87qLwDZRiwVZSYie29hH+bjT9N4r4NE4kfWo0YrGFlpi8GbEuiD9k9MgZMyG?=
 =?us-ascii?Q?Y5Di0g5x8EQWKcHex8QF2lmHHguugE7y95o4RSFSYFYCEPq+5XeuIGYGg+fq?=
 =?us-ascii?Q?GG0xOgzXeVfbsNa2UM9aiVVBl/yePPhXdhqvTmT3noGCikSeZjHSIknvinwe?=
 =?us-ascii?Q?G/sA044xZixcegnVS7ASzkpgLJ83gU5n28WrfbaDnE5y3SWLbBGnBGFk0bu2?=
 =?us-ascii?Q?91V3z5FCnAKvPvy5Nkf4n6XUFK1E85Axfn3OouabTRaGK+16lpW1v3uNPbad?=
 =?us-ascii?Q?KUBIcmjrsm4rZmbpr/3sjDYkYWqJNWkdA4PU68y4fFJSsfEoEbQohDwGCxHL?=
 =?us-ascii?Q?mdrFVVHuz9wrhmvvM0vEpaGFlyu5eujEkuznHWSsVx+J/lrj+7Ff7gUijf0t?=
 =?us-ascii?Q?kvhI4TB6xaDP3US1LBPhIznJQY94GW9G7wWCI7TYapjyWxVVD45wlk1pzGO6?=
 =?us-ascii?Q?7E3+ho/7+T2JMkCKZx2kei9Xw9RB/YPGQNmx8EYp8Ru376gDVbIkbhWwRAz+?=
 =?us-ascii?Q?P8lNig9tAtiaiHyGM4XXGiQmSIGVhA2QQyzjT0Q/vWxa1tHJZScj/I+CP7UV?=
 =?us-ascii?Q?los8aLNfGxY4jaxKktIg57veuuJWRB5fCwV4W/OgL0WWVXn7uNZ1LoE0yc6e?=
 =?us-ascii?Q?jATwrbwX3bkY44kPhmU5cCUhiX/9KCC48Bx6lpnmGsjY1cwdYQbFQ1P1/Fz8?=
 =?us-ascii?Q?kfKLb+ZbGs43GG5ueMyBcqUlURb1kCQJwZWEYxQakXoWBuo4M+lyRqENGNQw?=
 =?us-ascii?Q?5Nm/ZcG6d3vupKLAV600PALeaszL86zx9X7GTda9g3h5YWPVi7a5GpBT4rdG?=
 =?us-ascii?Q?FmhkC1qTYW83s26U/8DgPVLsXNyCgD8U3F8648tguEtxasTPdQrwu/1aiFIE?=
 =?us-ascii?Q?4b2HhefsdSPFji+nyT1QCef8aaeOxRaAYx+M5SfT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e697c98c-9947-4b5c-a353-08dbf65920b7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:44:46.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8cdLfTL7/PBvtNC5BPtL1MrTbffXVxfn4KoFiaishEvWe8M2zMh8BAEQhjtjLQa0KFag7m/L3hSjxt0lGcTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

On Wed, Dec 06, 2023 at 03:07:54PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./test_bridge_neigh_suppress.sh
> 
> Per-port ARP suppression - VLAN 10
> ----------------------------------
> TEST: arping                                                        [ OK ]
> TEST: ARP suppression                                               [ OK ]
> 
> ...
> 
> TEST: NS suppression (VLAN 20)                                      [ OK ]
> 
> Tests passed: 148
> Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

