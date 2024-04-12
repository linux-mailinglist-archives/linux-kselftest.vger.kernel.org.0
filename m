Return-Path: <linux-kselftest+bounces-7778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600648A28E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE69F1F24BB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D094E1B3;
	Fri, 12 Apr 2024 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6CbHdnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07A4D9F4;
	Fri, 12 Apr 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909239; cv=fail; b=mLWS7gmC+kSYPXW+1AVKDPlT7bL8IwXZLOVNHmJtlmg/NeSLQwniBwRbMLCKmDeajffAHeHyAj7qwuMtkqO3LycdY0IJj5oc9X9oJCR8EVGcczftZHwXAsZlPj5Zwx8cIRyH4W1wg5tYrmw9MpVhJqQ1WTJWvvAq603KcC7Tx7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909239; c=relaxed/simple;
	bh=a29Xlt3ldqwiCIxLDA5XJV1GDaiTCXwDkEhg60x1Pn4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lKLW/iu1bvEwvkuZCXkFsg1Ux9jmIQKbUievu3xlzHmFpCJI3HIUsWW+jC74HTrpGWNGIaO1zWTBTeuOSpsO/eHr6n2WCGNc6URNW024G261Wg7oV96UFZZnWqde7WEcHjC9UB7k7Zq2UN4jish+2QRPmhSwg45ooqT3L2diAG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c6CbHdnF; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwjQ/rAMNsW32sbrOkuPXcT2MBmC7hAXyBjK2UoJZ0BIx1XDtuzPJctQxj84U5oAXLHhCszvNKXej3kYXw32zhQ7/MdwNDmtcKqM4v2UOUdTPsyV/8Ei2d8uJ73wh6C9WD/cyRjSuIMTnaL1x/qwltLiJJ74DhqVg6J7TdXtG1BxzF8PIz45fhfzw1vXAo81UjK9LiXspfm0gGMFkIfLYoJvRuQq9h8bcT31wgkHavmMYc6mykk7vAvIIqZ8qvE7bsnOMaQPbK0iwk/to28Gvnh9cXt9tZwCCdZEukIxTiCzJwFBTEY21FuzZYGg3W2R3MN/sw1TIblPT71m/BupXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9fVnoREoprIGQ53rR40qfY/ptUpi3WXh8DgonCVeJ0=;
 b=IeeY42zaWgYKOwtP1bp2uRTqHHligQLOp/T1CZ/9lGtvxDML2mn1LEHfp2ZV/23GLz5uvaSm9z3PifYaCny232H32WbVeRckP++ZuDZep1+mIVd3eyNBxilOdnST7rt/WSjOx4wc8hwGuxnfqNRZNbFmD62t+7T9TNY7I5fy422mDhUaWnYgp+uDL9T1hZAVu2wN1InZ2PAfHVQLQA9FvyS3iTmFINaJuPen6RSbGOE2i9FVFa3vxW4fIldY5PZQE2I6TdAtCuVeyNR3wK44piFg/I3i2+g80fYcTNxP1v7A8fOKn7Dix3N/uQ0iyTGQNnF2cU0Pz3RWkxdmD5EoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9fVnoREoprIGQ53rR40qfY/ptUpi3WXh8DgonCVeJ0=;
 b=c6CbHdnF/RuerF1AIGOqqtKmT8Thw3q+CjPH9WKgUawpbZC7t6DM58maEu1znycNTcHIfE7kJ+aHQKmI9We1wVhj64LvhsNLB2Rtxny9OTudeXPlq9w5YwnxlyxBdiyk1GgAuBVfTPClzBnnsjJKZgQRLlDjlhZe1e8lQ8yB+K237CuGoyLSDhuar5d66EHHJ5PdqdNe8zlMkntqVPHn/Jx7r0xYZCGTqFmfr2OPfLYO62ZlRizHipCdXW852juuCk0AGDrYKYiTB7OAFEGgBJpw0u8LLOLsPxjnvAUDZoWCA9P5elDppav6SjhP44m+2dhoCzi1ila3my0HMGFSkQ==
Received: from MN2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:c0::15)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:07:16 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:c0:cafe::c5) by MN2PR05CA0002.outlook.office365.com
 (2603:10b6:208:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Fri, 12 Apr 2024 08:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:07:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:06:59 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:06:55 -0700
References: <20240411012815.174400-1-kuba@kernel.org>
 <20240411012815.174400-5-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] selftests: net: print full exception on
 failure
Date: Fri, 12 Apr 2024 10:02:57 +0200
In-Reply-To: <20240411012815.174400-5-kuba@kernel.org>
Message-ID: <87cyqvf1ic.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: a14736ac-947b-41ff-5415-08dc5ac79104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UPCpZY6mBTK4crhnJrM3OYdC0AM6rVKNkjbU3gmkXyHuUGK2adH2cbI00Ceves2B1KCX5vNVLDWaJyfk8wST5pux9WHXk4CSsY8pdxPmwDTGwhWnhnT2Vnz7x8BKFI2jvb9qlBngKUOS4I231oNjCi1TgAvUEdDwuufcRrzZoftiEN/mR747dwbsv6jrsR98KVlvsbVcnQzR0XDMMEDabOq+cOkQrOwbHRmFDsGSu+IaucF6bwZZcKeecbblizI3fdlbBChf0QWzqP6lROY//YfrKnChIF6o/TJqEql5DY1GsTvHLqZxnSt/+VOxBnAC2qdjVWjSwh+x0UcBJbI7VXSvTEOD5vEDZjqsIy2f35Blu0LIBW4Sd9iSQ4EAesn3OiOXxjxgOOo0HLcRPeuwYeLG6Y1xQxh/quE/98kM7ca89w8dRmeq4Kmg0fVo6eGZbsd2lmGx9ZuVfbvtls4fkOBib5+dsO2LSH63oWCx4QSwO0SiFgLwmqqOkbc64rQCi/7eWhcQ6LHmeqh5MHhxyqDVmHihQMQ5ZSN9sTAn+thfv+aG2TxrQ2Bw+fUqg6YE/hWVuCsv/a2JKNelT7q29Gz8DFdrRlIyIOFWbncPXy14VTNcqq1JVLBEICA3PPn6fYc2qTSiqDahFBydlAxquVvbvzwdGJkz+nuL2PQICqZzsXHOcizQxQiIr8ufLobl29IASiKKOk+xRQ/zTCEG5bhhhP069SerMyu3+lI8/MwYoUbZ8GxW1L8IaOYPy+iL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:07:15.5552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14736ac-947b-41ff-5415-08dc5ac79104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319


Jakub Kicinski <kuba@kernel.org> writes:

> Instead of a summary line print the full exception.
> This makes debugging Python tests much easier.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> @@ -85,7 +86,8 @@ KSFT_RESULT = None
>              totals['xfail'] += 1
>              continue
>          except Exception as e:
> -            for line in str(e).split('\n'):
> +            tb = traceback.format_exc()
> +            for line in tb.strip().split('\n'):

(The strip is necessary to get rid of trailing newlines.)

>                  ksft_pr("Exception|", line)
>              ktap_result(False, cnt, case)
>              totals['fail'] += 1


