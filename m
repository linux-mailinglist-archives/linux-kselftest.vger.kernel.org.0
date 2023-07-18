Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF2757961
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGRKkl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGRKkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 06:40:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E816F0;
        Tue, 18 Jul 2023 03:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUSMIYEZ/7rn4xR3BHLI9+FgELjI/DSfNmfzT+yo6zK+k5ASx7IU/GIk1xdCryZ6FON9WeJNLPcwEV5E0/mPPUBKOOhE/DfwzAd2jQlt9Wgew4uXFC3NwJjWMdCkSCoqb9IpoGonld/tWjRw8Q4jBOaUP1j0zhtVRMpOzQgl/KXFSBg1Pw6jstSMU5PmWei++aG0vDnlR3CpdaDmWEFlgkak7eoP+eZvbh5MT/cs++kpOAOVsa5wGL7uZOa4XgAUP7u96j0kR9mPyyzNbixsk2hPawfDX7hVMk+/R/3DKe8YsEY0FTJj1fCQX7Y1xzpuVQaOzcssnCYrRehEEIJ+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgGjT8mwW3EhIU2eBQk9ads3OsAZ4IEpyMHraXD+YxI=;
 b=Mfqncv8xtGxoWpTOODDF7UDE2Bo/2wHKSgS+dGsdrtM16vo/cL/LJ6tgp9lvudR7rbFG+s/FRhpRWbwoXLTkW4DdsaCGSzTF/g1xOKTOW5+gvAMFPzD2536c4G8mr1cytDjrG3hQvrRY2+awavZfAqQYSFfv4EjUxaS1lxwa4hapRp7dPC3mUOu4Icw3G7ycJrJ4x4HO/DLhPJa0WGZm0E7s42aL0k7fJqiybLQgUMPgnuU5rgaiQW7rCleDeepG2W005tWHA3RSccE3j7ulSK1yIJ4Aj5aNwgd4idgC7fb+uH+5jxJ7uHWsWqczRl08ZWqJne+0XUgSaCzf+Co+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgGjT8mwW3EhIU2eBQk9ads3OsAZ4IEpyMHraXD+YxI=;
 b=t6V9xq8QN1hfL/9/1Gto73mtcEk4tZq5WPrx29vDKFfv3Tqi8dWUMeVC2hx1yRyulDVm7Bs4GSZCBOrNhPgA8Niv1U2RshdxRk2nvy2XFwXWHUNFiujEtQV4mSyxDbPefrpX0R727l4a29Hko70effx6wUdaa+0uCqs7dcYwrZ+bzQ5oZa2thSO0sFPVA7v+ZR1fNE+xNzSKRRtHgjn00hDQS8RMAC705UZnYj1CZhaDVQw9NXajUjNEfsOGZ+3mS2Z+7cUjTck1wX2sNFj5s5WtROQm74ROPGEZ7IZAN7L0a0z25aMhpT3S78x/gALc8s6S0mofnSbtKQ9KAVAo9g==
Received: from DM6PR05CA0039.namprd05.prod.outlook.com (2603:10b6:5:335::8) by
 SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 10:40:35 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::2e) by DM6PR05CA0039.outlook.office365.com
 (2603:10b6:5:335::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 10:40:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 03:40:18 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 18 Jul
 2023 03:40:15 -0700
References: <856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr>
 <ZLY9yiaVwCGy5H3R@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Ido Schimmel <idosch@idosch.org>
CC:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <petrm@nvidia.com>
Subject: Re: [PROBLEM] selftests: net/forwarding/*.sh: 'Command line is not
 complete. Try option "help"'
Date:   Tue, 18 Jul 2023 12:35:18 +0200
In-Reply-To: <ZLY9yiaVwCGy5H3R@shredder>
Message-ID: <87edl5a4fm.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: c3018247-5273-41a5-61a6-08db877b6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgt+VkKwndVe1mpvpIXO01y/GEiw+UBizbfCLthGwBfsorxs0YOcSSIMb1A4SBhC1+sIYeBpLm7RtzRfhy2AZ9FxyWc0pR4XMa3XIB9IOI1YoemiUtWnPhdYhRmNJUqrTksGNO4SWG6FSfqKAV8bEXH9WJFTevvhHj076dA7vFCtVdGyZVXAwuqnaEv9P/eSxkw1nXXU1nV8+lBBl0rqe8haf8xt/899nlI7TGSdGDpSPJzSszRRAWLYK8hHV8ExpYuvaTC18BCmbbK01TLo+7lxZGXJBA9/3M57Z04Fpu6H/3Zqk02rMxDvaTkec1DPzsxWNsJPzNw4/4lwMnIiVsaHOUczVxaNRDzDa62c6VOT2sn0r/QyAWfE9K42YQMiPu0SVbBbwb8gES1GxUleOwJ0BsS0k8njXKMIlJZKH1wWeVRaYfVJdO38Glz9n/4cODaLDhHrZTN2L9LSGAhBmdJAotf9UFaXA8qJmP9NstCvtQXWURmlc2ZLIuO5UvYsq/7GF1n+JM8T9bNQQH3Ra7J7BvrcVtIhqroHW0IFj8eCpCeEQ/Ug2kFH28E3AqnJfVSF/P5lVUp6j0AEMpEwUdRxh1Ypb7sJzFppI8bSz2p1/drUvSwabTIjLK8lf4iZIlZGqafjbn2SDXRaPqLQqOtnIakX7M8Kg8UzYSnAUJPa7HTbfDqJPpV7KqNhK0tJErC1zAii33U0RzQ77KH5KCgdfsTfVfGw9XdCH3/JA3uxSf+9SsWMGabdClGyX9YQ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(478600001)(54906003)(336012)(186003)(26005)(107886003)(16526019)(70586007)(2906002)(316002)(41300700001)(6916009)(4326008)(82740400003)(5660300002)(7416002)(8936002)(8676002)(70206006)(7636003)(356005)(40460700003)(86362001)(36756003)(36860700001)(426003)(47076005)(2616005)(83380400001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:40:35.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3018247-5273-41a5-61a6-08db877b6b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Ido Schimmel <idosch@idosch.org> writes:

> On Mon, Jul 17, 2023 at 10:51:04PM +0200, Mirsad Todorovac wrote:
>> Tests fail with error message:
>> 
>> Command line is not complete. Try option "help"
>> Failed to create netif
>> 
>> The script
>> 
>> # tools/testing/seltests/net/forwarding/bridge_igmp.sh
>> 
>> bash `set -x` ends with an error:
>> 
>> ++ create_netif_veth
>> ++ local i
>> ++ (( i = 1 ))
>> ++ (( i <= NUM_NETIFS ))
>> ++ local j=2
>> ++ ip link show dev
>> ++ [[ 255 -ne 0 ]]
>> ++ ip link add type veth peer name
>> Command line is not complete. Try option "help"
>> ++ [[ 255 -ne 0 ]]
>> ++ echo 'Failed to create netif'
>> Failed to create netif
>> ++ exit 1
>> 
>> The problem seems to be linked with this piece of code of "lib.sh":
>> 
>> create_netif_veth()
>> {
>>         local i
>> 
>>         for ((i = 1; i <= NUM_NETIFS; ++i)); do
>>                 local j=$((i+1))
>> 
>>                 ip link show dev ${NETIFS[p$i]} &> /dev/null
>>                 if [[ $? -ne 0 ]]; then
>>                         ip link add ${NETIFS[p$i]} type veth \
>>                                 peer name ${NETIFS[p$j]}
>>                         if [[ $? -ne 0 ]]; then
>>                                 echo "Failed to create netif"
>>                                 exit 1
>>                         fi
>>                 fi
>>                 i=$j
>>         done
>> }
>> 
>> Somehow, ${NETIFS[p$i]} is evaluated to an empty string?
>
> You need to provide a configuration file in
> tools/testing/selftests/net/forwarding/forwarding.config. See
> tools/testing/selftests/net/forwarding/forwarding.config.sample for
> example.
>
> Another option is to provide the interfaces on the command line.
>
> ./bridge_igmp.sh veth0 veth1 veth2 veth3
>
> If no configuration file is present, we can try to assume that the
> tests are meant to be run with veth pairs and not with physical
> loopbacks. Something like:
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 71f7c0c49677..5b0183013017 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
>  WAIT_TIME=${WAIT_TIME:=5}
>  PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>  PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
> -NETIF_TYPE=${NETIF_TYPE:=veth}
> -NETIF_CREATE=${NETIF_CREATE:=yes}
>  MCD=${MCD:=smcrouted}
>  MC_CLI=${MC_CLI:=smcroutectl}
>  PING_COUNT=${PING_COUNT:=10}
> @@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>  REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>  STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
> +NETIF_TYPE=${NETIF_TYPE:=veth}
> +NETIF_CREATE=${NETIF_CREATE:=yes}
> +declare -A NETIFS=(
> +       [p1]=veth0
> +       [p2]=veth1
> +       [p3]=veth2
> +       [p4]=veth3
> +       [p5]=veth4
> +       [p6]=veth5
> +       [p7]=veth6
> +       [p8]=veth7
> +       [p9]=veth8
> +       [p10]=veth9
> +)
>  
>  relative_path="${BASH_SOURCE%/*}"
>  if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then

Or maybe this so that we get the exactly right number of interfaces?

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8491c97475ab..4fefdf9716dc 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -36,6 +36,16 @@ if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
 	relative_path="."
 fi
 
+if [[ ! -v NUM_NETIFS ]]; then
+	echo "SKIP: importer does not define \"NUM_NETIFS\""
+	exit $ksft_skip
+fi
+
+declare -A NETIFS
+for i in $(seq $NUM_NETIFS); do
+	NETIFS[p$i]=veth$i
+done
+
 if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
@@ -195,11 +205,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	require_command mreceive
 fi
 
-if [[ ! -v NUM_NETIFS ]]; then
-	echo "SKIP: importer does not define \"NUM_NETIFS\""
-	exit $ksft_skip
-fi
-
 ##############################################################################
 # Command line options handling
 
