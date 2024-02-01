Return-Path: <linux-kselftest+bounces-3929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919FA845619
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47912285695
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A915B99C;
	Thu,  1 Feb 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KanYkQ7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3915B98B;
	Thu,  1 Feb 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786185; cv=fail; b=RkowXptWZ+4zIFESUAggCsOdbIX6vW6OObMmImXNcTaqsVVB6pW+S2YzghLoelcq6PUHeJXpLuEum2mC2UkQF33cgb5cRFfwXAz+3MGdXsRuAUWUUVce8FyL3ZwI+nDRqqRTw+ETI9uKv64LCnlpa8s0Nn9LZmr9xvIPyz6RdSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786185; c=relaxed/simple;
	bh=Y/202ul0gH2lbB8cOaNDsrEo4xxQY3nKYXKMQGCkdN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kcxRnVQ7DrB0pYuyWO8PAn4acye49dSdLvaclQnXzmPqS9Ig1x9SHb6RY727HHATw7YTY8ZGer1NWe8zH5NSs6gXA166nOXsnK9xKiYrD+H5WJwKu1Or7dtrP7ATCily2VuoAM7CSOaoIHSMzwxTDRmFNVh7iaxb2n6kH2blVEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KanYkQ7Q; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEVt/k0fKaelEJv6JUNrwDDBiqiFBS0lEJVxsQJRh3HUJDWD+KrA+HkCmtgH64AQOs3/9xjnsWwXSUMk87HBMV1xpvE+1vpm2xIQegsi1nYwtH9hpZtAB7eIy7Y0DYoE6tFcYx0tcoVXxIfoO3uP4z6fqMDzrRM1BMk+a7W3dRIk/tM5KkVpuh29NtxSsYgL7BXRcJYNqhdlIf44swtjosQWc5ODraZe0pmRNE1TKhLbZXXyb1fdEetZPPJ6YJeKXQL/oq4sePb6BJyqHGaqVOKr/pm6vo0xr1qmBRvUgNIbGDh4srYnOmCfvY3It4IZS2+TplKKd7fEuyOfycOT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7fcwp/ozYCALx5/18jDnqCIB4Pm2XkM7j4rLROoxqE=;
 b=V/ke68pPPE/BWE9B3O3w8DSFY4im0yFhFatyVJK6N1sljg+BFjtV+yCKr7ul23MVttfrOcnllbvhjHYBErw5kIrB65ZtJBBmz8FvlQ9vHcYxUvt563nH2HgRAnfRSjr2Kvf8SWj51jSqLS0qCFw/NSFrNhQ5a0xH/xyN1YjTPy4dAXu+WDhsKpQlQwQbmP5UwpOFcJp55Ji22feO30k3Lu9ga9hh8PploKPhK8C0q/uCMbvaQaRsN6dLJW1DXJpM6Rx6dHeyUT4wzDGRJIeoSeC5Vvbplybrblk4S2cNct1Nb9YRwCMK6hTl7NXm8cTjhrqFGXt6M6zkUH4O/yumzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7fcwp/ozYCALx5/18jDnqCIB4Pm2XkM7j4rLROoxqE=;
 b=KanYkQ7QZzFdSVSnB1fJSxDj2p9YY1l+MUwN9Azwk5JnR6ESzekrgaG8zh3odZL79acj030K4EL1RGnpOzvhF1j9NivlZyfB5Saox5t84m08QbjCxcoeYcopVxp9UzJ62E0+jZd8HTQsFaJu2WDx5DlC2tWIdZAr8dCD1MJQlONN+45CIzToMZ/FsJoyj5YrVobwaBjfLhFKjNe9b9eiRTGQ9/mg1djA/bx3laYhrHxhLLk2eXBcuFWA5ApN2eaxKkVbh2nwk7dkhg/2DjEyTB59hXe98onh5NgIv9Hj+Uxo8A8P00M8VKKmV1BEdgJaihU6zX5RlZHsX+10zpKZpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 11:16:17 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::c69b:917f:8fa6:7de7]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::c69b:917f:8fa6:7de7%3]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 11:16:17 +0000
Date: Thu, 1 Feb 2024 13:16:07 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	shuah@kernel.org, razor@blackwall.org
Subject: Re: [PATCH net-next] selftests: net: Fix bridge backup port test
 flakiness
Message-ID: <Zbt9dxyJHszL4Aoy@shredder>
References: <20240201080516.3585867-1-idosch@nvidia.com>
 <4cca1f0d3c015a6ab9e371b1639f6c3c29b33024.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cca1f0d3c015a6ab9e371b1639f6c3c29b33024.camel@redhat.com>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 87beab9b-65b9-463b-f7f3-08dc231735ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FgBsKn06+h6v+Gn3Xy/kVkwDngf+e1leuSNjV8cQ7QjEv9qv5Q2Wh/gZzIWg3YlFNr++mnplZWxzCFA5GbnIpNTDIsKdH7X/L5mA3Mb4L/+QjsoaCerzD2Q+BgCswK4QxwNqCvMjPJMv/bV1Bcca1IurWLaoon64fjre10zxrjW2nMI463TzGFaHlTeOH4j8oHH2Rf/AVDQOKZ3n9QEs2DCeN89VWy0Jo08jgv1G9hAGdc6JcgFsln+keTgDPoqcUvGWK/hi/g9bO/cuM8zqIFfPm78WFaAp8v/A6STPvGdShWZj2DV0CRIwbPsFnSk3ekZ0pmkE8W2MBLjaZ8gvqjxNsMQNtuv93YkZRxZ729AQFZkA5JQPjOSnQEV5ZQ6+7jJf7QQKgB+KJilaPkGJ+RyYg/gJh25FFct91poWm9+WgyPIPQgXNhi9KJS74ReRtkobgiooe4Ay2aTm/Kmy/Vy/I3z2A0qDJTzts8HfuT+QGCjrfXXY1rmGRZGS2QZXTQe+gAng0XbLVmmgFqyFIzlhH4UKU4JLb4xCK5uJfwdV5h82/p7MfdmNF/S3sFGS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(478600001)(6506007)(6486002)(41300700001)(6666004)(33716001)(6512007)(8676002)(8936002)(4326008)(9686003)(66556008)(316002)(66946007)(6916009)(66476007)(2906002)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lOZf+iFoTPo+lH//PiXHIVk1OZMaPrltgemVG8p3KBBX8x97x+uBdMfHfGe?=
 =?us-ascii?Q?ZybwQq3GC6b1bImYfvs547yCooMqpm/zhk8Cg5UMV0pOpDzmlmJ4bTE1d9kf?=
 =?us-ascii?Q?B8rXXBC/1HLiuW+uL+HID7LNZctTvnDVkNQQurOdhnfA0jWjNjqUoMs7klij?=
 =?us-ascii?Q?erLa41FlFK0Q2fcx/V9kfFNlMuiqySN7Q25A0Jf6pGY/6+24rdoP6zIYqY6D?=
 =?us-ascii?Q?0IXihtYZNOn/qi2hLujPlfF8RZa3UqD5fNa6VvMUr3kd9MAhBPtu1Odtnncf?=
 =?us-ascii?Q?wPJVPJ8eNssXZ/zXHBmfufPTKg8OcbE6pW4XL1PHA6bv6dbji7MmvWhoWi5n?=
 =?us-ascii?Q?rwG/QL+Otspk7jd6Tv0sQQSO+ClMc1mAibU3Z7vPoCU7rOCZHE3NcsoeU3xF?=
 =?us-ascii?Q?DODSLDNaEnxD+Igs57JLzt7nGVTbWWPJMn8gPN/oRAPHWmYE5MrBOXbNzUSf?=
 =?us-ascii?Q?cWvzN4z4gG3z+eaDwnOxGy3Rzl0ntQWm6G/H/ZGRZbzvB93J8uebHZ9HelE/?=
 =?us-ascii?Q?teu/YcyFsX1gCR/0J4/Ffm5YySdtJsercthMz9OK3CkAfsFAj6HO2i3MzEpD?=
 =?us-ascii?Q?NJHRyxFEgnAqlQ2uSxLsRAmXpYS2UIensltc32J0K3o7wj+Gd5Klap+MrMH/?=
 =?us-ascii?Q?BLSewJpOPzMD674QUEEBGohR12gn3NbMy58DNNvD0kY+xfi5f2wJc/0iLgrv?=
 =?us-ascii?Q?axTuwZoxcRLvwqf2Agoqh867Mue3K0qOBB1NJ9SxIlzorIW+12nCSJU/3UaV?=
 =?us-ascii?Q?Y1YTvGxtgmY1dnG9B0AF+CZvniak7oWk5z0EE05JkiuTnreSxAm076Qxvrwr?=
 =?us-ascii?Q?cQKWR6APhjTMeu8g/dVMjiJZ6G5NaGXCQFTvN0nskZbilyzxHHwgdiuVx/Pv?=
 =?us-ascii?Q?SkYHobrxTyCE9AnhQTAZ+tDP2q/j/VVbpFrPf0MdDoFtcS1cd0WHxxLpPWy9?=
 =?us-ascii?Q?VSqSxc+sv6jLp+Qppk0yL4vRuPyHxa6DlzJcsfccpYVS5t0U+pjXbYrW6u5D?=
 =?us-ascii?Q?47fhiVB1S1vKKbp3ynaRzPr9B80+YRe8danTW7xfWqNUwXVjW35SZnR8Qpbx?=
 =?us-ascii?Q?6m1pmW1x8+N6Mx+f7hrwG6NtfyUbkEEx1we8ujVA0z0NpYoOmdWWb46toYfU?=
 =?us-ascii?Q?wut3VGabQc+SnR1wfGGynsBBVgYKD5LM08D/lH0KEMCThatDPqHH580GtJa1?=
 =?us-ascii?Q?CC20CUyWcxloio9Kz0Up+VtEhz/F4NU0vSd6uTZMFKLZIZpfhi4le057GRpY?=
 =?us-ascii?Q?aIZiBLbN/gmg3DOwoccw4nAxYcBi+qwm0jeRPTQPL3Tm8vuHK4JX1TOve53v?=
 =?us-ascii?Q?v5vpJRZsdNgnMA1dQf8sd0wI+RO4vu6Yq/jOVpKOClgXZ/tsvZ7gr+jHhDJ2?=
 =?us-ascii?Q?5lZvFZGKDN2pvCTDdV75yvt+aNN2Rn/d9Gi2ZbqHwUqDodEW6lvq6yAD4yxX?=
 =?us-ascii?Q?mux3DWjVR4GMG69MQQWzrotXg66Ud0kn2B72eyyCO31ZeSscQxV2Sn2aclR0?=
 =?us-ascii?Q?ErXHlo4jtVkqsADnDx/y3QWhqoA9m+x61uCh4wWv/3l+UQH+XIRgewgCriEG?=
 =?us-ascii?Q?+OnKUgA/f8W1KkN8azrxpF3Qk9LgT5fgcDfsG7S2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87beab9b-65b9-463b-f7f3-08dc231735ae
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 11:16:17.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccwSbrz7bg/Epv4B0Y3pRYjEd7YUwChh1LbyugeNOF7C52kzrzXpKMS1+dA6cWOP7YGf9O6FzLlliN/NGSH18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

On Thu, Feb 01, 2024 at 10:34:52AM +0100, Paolo Abeni wrote:
> What about adding an helper alike wait_local_port_listen(), checking
> for bridge link status in short intervals, to likely reduce the overall
> wait time?

What about the below?

diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/tools/testing/selftests/net/test_bridge_backup_port.sh
index 70a7d87ba2d2..1b3f89e2b86e 100755
--- a/tools/testing/selftests/net/test_bridge_backup_port.sh
+++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
@@ -124,6 +124,16 @@ tc_check_packets()
 	[[ $pkts == $count ]]
 }
 
+bridge_link_check()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local state=$1; shift
+
+	bridge -n $ns -d -j link show dev $dev | \
+		jq -e ".[][\"state\"] == \"$state\"" &> /dev/null
+}
+
 ################################################################################
 # Setup
 
@@ -259,6 +269,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -268,6 +279,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure vx0 as the backup port of swp1 and check that packets are
@@ -284,6 +296,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -293,6 +306,7 @@ backup_port()
 	log_test $? 0 "Forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -314,6 +328,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -369,6 +384,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -382,6 +398,7 @@ backup_nhid()
 	log_test $? 0 "Forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure nexthop ID 10 as the backup nexthop ID of swp1 and check
@@ -398,6 +415,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -411,6 +429,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -441,6 +460,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -497,6 +517,7 @@ backup_nhid_invalid()
 	log_test $? 0 "Valid nexthop as backup nexthop"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -604,7 +625,9 @@ backup_nhid_ping()
 	run_cmd "bridge -n $sw2 link set dev swp1 backup_nhid 10"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	run_cmd "ip -n $sw2 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw2 swp1 disabled
 
 	run_cmd "ip netns exec $sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
 	log_test $? 0 "Ping with backup nexthop ID"

