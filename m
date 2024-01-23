Return-Path: <linux-kselftest+bounces-3427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F6839665
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CD0B26587
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207668002B;
	Tue, 23 Jan 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQ6qsU2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202C811F1;
	Tue, 23 Jan 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030852; cv=fail; b=LrG19KAbUbLr5g/ZUx1xbs+KsOxnFJJ489blmj2mA5IGXlMY7qseiQGoCtcTqp8d33x+PgtN+B2+6bgxOpFnBoUYeDm5TYOwVuT0urR/66Z7+zpyj/zjmmOq3DlBdajjMpL3Qh3TR0P8zeIM89GVe8QliL/nkXAL6bdbpAFF4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030852; c=relaxed/simple;
	bh=TKSSSrmWjdkSvjJ8t9g3K0WpluHvfOUrNpziAe62x8c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=euCbGP3PVSMBVw7iWMZC8FA25HrTmoPqJvIGCmugvxzcd38xHm70g2Z3pJ1hNbjVf7N4ZrBteEPe5DnQe2fQiUguyWtNll+2V4YDYqSHF910nn9JjPy3PbLHT4mGJjc0EwEvt5EogeV5pbb7RJKI9cWacbeSQhyOZQpAJsvxHWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQ6qsU2z; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw7d0iI816qgJMu27N7L3Xa2nnODwRdsOiD5f9QFwvfOHQG83l7JIyLKBWodCCEL7Fa/yi5WqF0MsmZd/TIZFK2geZhvVCPMoosQsQ6IqnDTzjtT/w/ctw05Bscr7mL09PP05bdcmL9skbwd9KjVBVZshEsu6m5+pJnaMZvh5TfhOzpolalQllc7P+IcWIqHFnGgo3p57fbypuy2Pfo/GW/Jusm7DGmeF/J5L9AmjBS6etOqqRdJr4+vESuxUtAEvEGytCos8DrM8kL7r6c7Ps5HLjBv17yngWxt80rtCmmzInVx9ZxrSNfxADL2q1f/uU5ar4AXBD7iAZ8Tu8eUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNa8sYyO/+1F2nnjTxcl54zicZwJm/n0zrr9KzxvYhc=;
 b=FxX1UafqB8MxJCZiTEeIIoyfJnvjcC6adxgu+PAP7V/AbwS6cVZgfQ+D6VUUonZZnBbX29qkEaFEmnrD473YgTcZPEh7wacQoG5VsCujltMgw2eNSHawOR6iwIu+8jCriEMQp0oEVhLBwANSY6bk9bqQPaDxXVPoWLFXv/eiV+zd0fvJr/Y2dTVt+FPTWvint47o9UcA7SgV9newuq0FuTxCcjvQYRfUXjbcPJ6dW3ivChC4ax+nKzBykRhVW+yC9DJs6+lh3VLHLXtDCPcAKgXBJmzhvg9vwI2Kbwr8HfiutAbgiVrR5fonLFFpmApw9or9tg3jUcU4DALr32YnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNa8sYyO/+1F2nnjTxcl54zicZwJm/n0zrr9KzxvYhc=;
 b=UQ6qsU2z3d34cOOtpRxIFKjUYWOaojST0TFhAHZjc6/hR4kQ3D3loehmXOSLoe6THcD0Oer7ceBD8L8xHTMJeqHir+H/13nFpGml86dY5/WcflJx2lEHPjz5JmmtFTRk+1AJx46Dn840XjG8UR1mZi8Rtmb2/C/0su676R6KA4e4sXhlR955++UUJWVhtCDlhjBKExecPgPdNoIUgFiPr2KMqSD/uIcpD+rqtFc7xxf/Va0IFYL9Ex9tBSnl5DwSE/zRLiXDtK3txHzrShxg21jdhfQ1NQONg+06ILnCxIwE0C4bdqdACLDA1kmZTCbj8SjYWTXDHJt6vpPkB7VVTA==
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 17:27:26 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::9f) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Tue, 23 Jan 2024 17:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 17:27:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 09:27:15 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 09:27:13 -0800
References: <20240122091612.3f1a3e3d@kernel.org> <87fryonx35.fsf@nvidia.com>
 <20240123073412.063bc08e@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
	<netdev-driver-reviewers@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Date: Tue, 23 Jan 2024 18:04:19 +0100
In-Reply-To: <20240123073412.063bc08e@kernel.org>
Message-ID: <87y1cgm040.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a62df6e-0498-4ff5-d117-08dc1c389167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4sVNKljhB0e9ArobEqIdht5J+Y//cZB1y4+FTJyJxFabw3kMdKwfzjxM7IXLMMWMsq16Xc/QZveyRJ7TUqTcEJndfsZNWYAoRCbOS63dBUxDypLJsqQulTssOoQ+Y64Sz0mVmS/I4hHvlMgFPrM52EZrna/l9YAI49KP1veESBtyl5BaXaAJAtVovwGfPM84GzXPN3k64vtWbWOqncRVvQA2TrfoV/GM7YlNWsmkR4CiH0VIDtauIKrTFAcWdLnj7uRH2+VSDaP6r9qdXwMBCtasBpskqz2IooVcCJQ5h57DdYmcriY1kq3ljFoLr9LI5LaE3wHVGDSv+cRvjxNwFNE0rN54eLYK15cptHgmtZ0HEL9Uz+TiFEyWJ8j+QaTCpxH4LgywYJ8xVJ1d13QMiJRAYeHDlRH/20EHUTtveMc9kSWnoLR3ktwp3ABf39Y4FDZKxtLTY/pkAAODI9sp0BN7Fvzuq8UC8tVuinuzVmWeFlQI3PwZNCjcr8t7nPd+1IbVg4k17eR8tS+ad3kkMpSOVh2T0vkwg7MEefpu5fACWu7x6sNm/ZJsJPdkmH3Arlew84KwP0nHoqV2quqBuzgLGu/YOxElKDHWPW/khe06Xc46OMoCkwYK/6aNTp5uTEswN8VkCB08+FyPiHXdZ6ChGYsdfVsJdRihzkdHmKsyZbGpSsvJdgzWBgQRIZMGH8lefQsWXKWxMYSuONMZMzK/6XJGTGdyEbv5WJvDUMxQRXbcBRf0LZ+0zmuGRyNK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(40480700001)(40460700003)(356005)(7636003)(82740400003)(4326008)(8936002)(2616005)(336012)(2906002)(5660300002)(16526019)(26005)(36756003)(426003)(316002)(70586007)(8676002)(54906003)(6916009)(86362001)(70206006)(478600001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:27:26.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a62df6e-0498-4ff5-d117-08dc1c389167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 23 Jan 2024 10:55:09 +0100 Petr Machata wrote:
>> > If you authored any net or drivers/net selftests, please look around
>> > and see if they are passing. If not - send patches or LMK what I need
>> > to do to make them pass on the runner.. Make sure to scroll down to 
>> > the "Not reporting to patchwork" section.  
>> 
>> A whole bunch of them fail because of no IPv6 support in the runner
>> kernel. E.g. this from bridge-mdb.sh[0]:
>
> Thanks a lot for investigating! I take it that you're looking at
> forwarding? Please send a patch to add the missing configs to
>
> tools/testing/selftests/net/forwarding/config

OK.

> The runner uses that to configure the kernel on top of defconfig.
>
> Unless I'm doing it wrong and the sub-directories are supposed to
> inherit the parent directory's config? So net/forwarding/ should
> be built with net/'s config? I could not find the info in docs,
> does anyone know?

I don't think they are, net/config defines CONFIG_VXLAN, but then the
vxlan tests still complain about unknown device type. Though maybe
there's another device type that it's missing...

What do I do to feed the config file to some build script to get a
kernel image to test? I can of course just do something like
cat config | xargs -n1 scripts/config -m, but I expect there's some
automation for it and I just can't find it.

