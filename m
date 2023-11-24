Return-Path: <linux-kselftest+bounces-549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1497F7774
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058F228215A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAC2E844;
	Fri, 24 Nov 2023 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nwob7hb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35931727;
	Fri, 24 Nov 2023 07:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6eCe5x8/4sf9CzrtBXIIG0MmgfKvSMo9e8H/ThelstpqXX33nvCJz5Lzus/ge2SyusofN40zs0toy8K4Za4K+rX4FT+sKI3nhyr2nToe3SUZVYIuxzLvI2Tmt7rRW8uddP0n2Rms5NkvVpwuBmAZPRpyyrpAVjr4RWCGXg+ZRuFChbqu2sRsceMxHLu07nsLkWU8PUiC2ujyle3kwZqfNNj5dSBHJbIXMwRRjC7vz5FfwvzAohrofTbJpTQ2DMTzbmPvgjvEVQ0ZmldZyqcyHwEc8yCdYCjOpOCe33Qf+fnpLQ8y+eL3TSOHmkJHj5NCvqiflUJ0P4DAzA2QMpp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAo2kPA4CkTwe1J4538/iteFQp7nZysQhBpI9EQwr7I=;
 b=hbgWMDsazU501LeIgett8o9lcSU5qTB7NN0PXIzW0vC6Y+SmM+lfSbK1uNpDn+br+FFNowPNZuWBUJss32RlVPEwXVCQvVRusZcMcGEadMD4UG/3tv5Nrj1z3Nw7rMm5YjXGc3mkmlvkxczTRRULSKrFaCJbSjTVfMOh0UEM5Z4LU6DWBMWGliLg3H1yaTQca1RT3PJAKDQyja1po2VpoLi1PzPoT+tXJDeLMWm8kFLYsBcoGQLLnKPUVnL/GwTaBzSDd7yqRvKfPn3x6bVOgfJLvhRPOTXjJ9HjJnK2z05lNWXeZBDHL+mSBzy80eP05Ma4vUPsRneVjrBNrQcxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAo2kPA4CkTwe1J4538/iteFQp7nZysQhBpI9EQwr7I=;
 b=Nwob7hb0eXv7faZqwveDb807kv2j/ng2TFame++sRD0uVUbmANE/KAfrMZyydKQYx1KQdb0Atr5R4qsUmCp88tVvAs38e9H9SDhGMPM8NJ7ICn7sMs97l860UP92P74bFcTVNEUW1QPcRX0/7JzE2Yy1q4yGTv/ru9B7/Tu3s0NjEIesIfjuVaFeNjiQSdJJav2tHMsEfur+569HVwzoERCB2hGwnQO76QC7JBmc4ZKv1NPm7pErycpo75j6MH3ijCq+YFDFYYt75uRo/RjglsIpEBEsAiFeUI7hfNToH10iisYWBkrF7GHNoOazO0s4pKPmL8uA4m6bYSbV0nlznA==
Received: from SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 15:16:55 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::23) by SN7P220CA0001.outlook.office365.com
 (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Fri, 24 Nov 2023 15:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 15:16:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 07:16:34 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 07:16:30 -0800
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>, Po-Hsu Lin
	<po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Brown" <broonie@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Date: Fri, 24 Nov 2023 15:35:51 +0100
In-Reply-To: <20231124092736.3673263-2-liuhangbin@gmail.com>
Message-ID: <87cyvzfagj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW3PR12MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af38e0e-1ed8-49d9-e785-08dbed006512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C5BU6vGv9/axmCmYJh+7G8Pbjte73fAyH+DAuu6DifMplOupFSCn7N7u3X6pwz0Wqsy76mpDPJOvZfDXNoLJ6nyk7S+qY+Hfg7xq3XA2lVVhF6RJtZaCBtLtgH3Q2YsIWzeIwkZWVnZWDxoySDKm5NLTm8ZTIYgl3+SBsodu8THO7liM4LTa+u0JFw2U9lWxKEIVJGAby4/xytfy3BYrV0n7GRG6Sq+qiBylWy4Pa4h3fxrjxAXzXFkmofIPPV9/6aAtJ7mbbX6vIoihUFVU4/Q/OjQIrn1ya+6x6Z0JL80Vw6uhtmt4W8/LHjFyYs+YYiok2uYtB+JgKqBLqjDfbpJn1nj0AojRWoKCYv3x7BtCLHjEtEJ7RIhnlkUXa7CCGIij9m/JNlfaMDFYT5vWnrVB54XtapxxSEw4FPN9MdRgDhImKNfSsuByI0V2x7syELCED1N3q8A+ucGZIIHQrmuIplc/wiYhkSWQDUD0m2kRyACrrTZfF5XjJikvXN8vLk00Z0FUjy6uMuzFxk60XmosBbIucLb7DyIEwWRvoQ62LSl9ggZkk9xkzxj14e9+86JofBMoyKGLleHVaOBB4X3ZT29Q3XbWrYDYe8g/wXNouiUsDQKtAygxufXkWfcYQ16KSRr0uyu+DeZsek83xkYoxItbQwIdddgc2ttH0JOMmqA1+nkN6nO3K9Cz16qUU9v3Y72P7uiw4RpG70u4Wz6cpYhcKSTqIK5cQmjbJmrz8pgLpCSf8P3TT0AbDhVio2rXjCud00KiFi3Dslv4qA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(7636003)(7416002)(40480700001)(356005)(6666004)(4326008)(36756003)(8676002)(8936002)(86362001)(5660300002)(47076005)(41300700001)(36860700001)(2906002)(6916009)(40460700003)(82740400003)(26005)(16526019)(83380400001)(2616005)(478600001)(336012)(426003)(966005)(316002)(54906003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 15:16:55.3171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af38e0e-1ed8-49d9-e785-08dbed006512
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569


Hangbin Liu <liuhangbin@gmail.com> writes:

> +cleanup_ns()
> +{
> +	local ns=""
> +	local errexit=0
> +
> +	# disable errexit temporary
> +	if [[ $- =~ "e" ]]; then
> +		errexit=1
> +		set +e
> +	fi
> +
> +	for ns in "$@"; do
> +		ip netns delete "${ns}" &> /dev/null
> +		busywait 2 "ip netns list | grep -vq $1" &> /dev/null

The grep would get confused by substrings of other names.
This should be grep -vq "^$ns$".

> +		if ip netns list | grep -q $1; then

Busywait returns != 0 when the wait condition is not reached within a
given time. So it should be possible to roll the duplicated if-grep into
the busywait line like so:

		if ! busywait 2 "ip netns etc."; then

> +			echo "Failed to remove namespace $1"
> +			return $ksft_skip

This does not restore the errexit.

I think it might be clearest to have this function as a helper, say
__cleanup_ns, and then have a wrapper that does the errexit management:

cleanup_ns()
{
	local errexit
	local rc

	# disable errexit temporarily
	if [[ $- =~ "e" ]]; then
		errexit=1
		set +e
	fi

	__cleanup_ns "$@"
	rc=$?

	[ $errexit -eq 1 ] && set -e
	return $rc
}

If this comes up more often, we can have a helper like
with_disabled_errexit or whatever, that does this management and
dispatches to "$@", so cleanup_ns() would become:

cleanup_ns()
{
	with_disabled_errexit __cleanup_ns "$@"
}

> +		fi
> +	done
> +
> +	[ $errexit -eq 1 ] && set -e
> +	return 0
> +}
> +
> +# By default, remove all netns before EXIT.
> +cleanup_all_ns()
> +{
> +	cleanup_ns $NS_LIST
> +}
> +trap cleanup_all_ns EXIT

Hmm, OK, this is a showstopper for inclusion from forwarding/lib.sh,
because basically all users of forwarding/lib.sh use the EXIT trap.

I wonder if we need something like these push_cleanup / on_exit helpers:

	https://github.com/pmachata/stuff/blob/master/ptp-test/lib.sh#L15

But I don't want to force this on your already large patchset :)
So just ignore the bit about including from forwarding/lib.sh.

> +# setup netns with given names as prefix. e.g
> +# setup_ns local remote
> +setup_ns()
> +{
> +	local ns=""
> +	# the ns list we created in this call
> +	local ns_list=""
> +	while [ -n "$1" ]; do

I would find it more readable if this used the same iteration approach
as the 'for ns in "$@"' above. The $1/shift approach used here is
somewhat confusing.

> +		# Some test may setup/remove same netns multi times
> +		if unset $1 2> /dev/null; then
> +			ns="${1,,}-$(mktemp -u XXXXXX)"
> +			eval readonly $1=$ns
> +		else
> +			eval ns='$'$1
> +			cleanup_ns $ns
> +
> +		fi
> +
> +		ip netns add $ns
> +		if ! ip netns list | grep -q $ns; then

As above, the grep could get confused. But in fact wouldn't just
checking the exit code of ip netns add be enough?

> +			echo "Failed to create namespace $1"
> +			cleanup_ns $ns_list
> +			return $ksft_skip
> +		fi
> +		ip -n $ns link set lo up
> +		ns_list="$ns_list $ns"
> +
> +		shift
> +	done
> +	NS_LIST="$NS_LIST $ns_list"
> +}


