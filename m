Return-Path: <linux-kselftest+bounces-40231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B30B3ACF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF061C858D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75B263C8E;
	Thu, 28 Aug 2025 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b="kG5UKnw8";
	dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b="ZLbPSrig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fallback4.mail.ox.ac.uk (fallback4.mail.ox.ac.uk [129.67.1.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6721146C;
	Thu, 28 Aug 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=129.67.1.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417603; cv=fail; b=irnkaZADNEV7CnIqweeeDRA1MXJRp4IAiJtfqKx9QsiFSIzesS5Gpovvk3WdSisH71DhqC2QvLZaKqwEp2lUAe1JJkg7ods4NqhZ3b0raxOTusi+r+7En4vhp81HSUGmk4Ek6qxNcGY04nEoHJq47jtapRSAUGxNOPRz9efyr0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417603; c=relaxed/simple;
	bh=HoKQjcNTbLr2hnk28qJuotqMOhlczQp+7v+3teVc//g=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MnHcdV5F7hKY+KW8pLbCUgOY0PzrVav544kZ39aybd9AHIUDgixy8kMYsNbr2vNHBS6QPVazPIgHhKdgQwJq7kChj5uYW40y+WqvVmhNuq8nw5ztiQuaTxR2AZ6o9WjgWPd1NCjQPnok0ELQSx5OUwCr1CQxE/i3Zjw07gtJxj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk; spf=pass smtp.mailfrom=magd.ox.ac.uk; dkim=pass (2048-bit key) header.d=ox.ac.uk header.i=@ox.ac.uk header.b=kG5UKnw8; dkim=pass (2048-bit key) header.d=UniOxfordNexus.onmicrosoft.com header.i=@UniOxfordNexus.onmicrosoft.com header.b=ZLbPSrig; arc=fail smtp.client-ip=129.67.1.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=magd.ox.ac.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magd.ox.ac.uk
Received: from relay18.mail.ox.ac.uk ([163.1.2.165])
	by fallback4.mail.ox.ac.uk with esmtp (Exim 4.92)
	(envelope-from <praveen.balakrishnan@magd.ox.ac.uk>)
	id 1urjvu-0002MW-Gv; Thu, 28 Aug 2025 22:13:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ox.ac.uk;
	 s=flood; h=MIME-Version:Content-Type:Message-Id:Date:Subject:CC:To:From:
	reply-to; bh=fvq77BtEl8U1b531Qv3Buv5jXhzDTV8N0fdosavxBA8=; t=1756415602;
	x=1757279602; b=kG5UKnw8qA2qyeH3NUTwzaVhdzaMw9lc3rTtEbyxvii2S85Eo7yn7EFK3d5CC
	RfQmTw8b/7LMTAjn76Zbvb/4fmtJI5sKxHYwBG+LmrRyKNg5CLBdGvwxlu3xfNjQ8ltKD3DW93nNa
	D9mZma9gtLJBwnpdaZtMH1cpfNKImQj2hrGcWwIdkv50IDo+HydpGF3BxuQo8fxsn77O6HSJzDcET
	kHqm9zykPeK22KcDeBtbcyWHrPJtQ0LiXYJGKaanszUeMfXoPW+AQyMss4x3fatXu6m712+dpOrif
	IRHBDFDbnihDnM9SwyMG5eustELoR+B2ZKp42QnIvaTP5G9sfg==;
Received: from ex02.nexus.ox.ac.uk ([163.1.154.242] helo=EX02.ad.oak.ox.ac.uk)
	by relay18.mail.ox.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <praveen.balakrishnan@magd.ox.ac.uk>)
	id 1urjvX-0006e0-8p; Thu, 28 Aug 2025 22:12:59 +0100
Received: from EX03.ad.oak.ox.ac.uk (163.1.154.243) by EX02.ad.oak.ox.ac.uk
 (163.1.154.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 28 Aug
 2025 22:12:57 +0100
Received: from CWXP265CU008.outbound.protection.outlook.com (40.93.68.7) by
 EX03.ad.oak.ox.ac.uk (163.1.154.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 28 Aug 2025 22:12:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzPdckFDe3aIkqAUyHv2/194Q4kjL6fkVG0LdSHU3huUUflMybzZEj0VZ/63haP6xS8ApQZb8REyAcUuICgCFF5ou7syKxMFtwUG1b2JD7Vz61/rOiHdWRvZehzLW+iRnm1rxpzsf8c02IIQGtyen/HKA5KQG1amME14ROaxReNwrtIrRKTC+iFD9xLTPV2SWLYVe+8nC1GpKsaup8+/sv5MaAzMEw/KY6C/ZBDOZgXc17S+/XB3UMSfC/aQUNtf7XjRBWMccTEcYKxNCGqUE3hnkgjO4xU3Rs+xI78X2+hG90LNlua9lyQk+Irlw4FA/IOn/xi+BJ93eqkZvvelww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvq77BtEl8U1b531Qv3Buv5jXhzDTV8N0fdosavxBA8=;
 b=vzOYJiImr4kJyKYORcrAheJv47Y3Br8oEZBxUGLgsRCYUEjzQrVi6xhw9QMMmlI77ivBCwoWJ5dLMRtf0gMRfbrYgbIO7x5hU5XZYZXqjWKAjaPBCS6IDW0jZ0zjmN9m/xRChJjMzTeg1FbJ8zU5TKLCqSIVv4r7YYH2Hl5XBoac/fb6kho0iUoQBRlzm+iEdoxr9rqIeaJLgkQnnGJuACA+PGGjYlzHYW9Asj9PBtDVBKROuSIq0JBdA1EFdP59gjyrJMuRem9B9bR8Db0B8Zk55HGqXoKRt8iWGIcwT1muYTfeuS1rdujx4iKzWpq4QWod2PrEMYvAXUuMdgay3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=magd.ox.ac.uk; dmarc=pass action=none
 header.from=magd.ox.ac.uk; dkim=pass header.d=magd.ox.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UniOxfordNexus.onmicrosoft.com; s=selector2-UniOxfordNexus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvq77BtEl8U1b531Qv3Buv5jXhzDTV8N0fdosavxBA8=;
 b=ZLbPSrigtA4iIKwluctY8/3D7z9g8fa5p1ETwpxZ2CTS7kRiNeWQPntsYkEorp1+Rxy7DID7dwaCw7R7uh8B5ML7BY7o4IOveQiJvDBOYBTQ3VjqDY8EX4QcDfGUJgiysiyWcwogV3dsQsXyFs7zFkhxKt+DzyuB69RBvgxace/lhtahTdvVh+UwaiREGOKNT2ByCTWtRojCRffvczNJB/0hEirkRIbJ9UZy1UUjZ5iihbuaChiGkbQuVqQiGdjBxwhq4RjmfyQTcIgHHFY3KDlxyz/xOBZu3iMsTYvwbWdkweJDDB5iiL//3zXKdgpiNOn8uH3tTDaNgHAxqI3esQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=magd.ox.ac.uk;
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:323::12)
 by LO7P265MB7982.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:466::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Thu, 28 Aug
 2025 21:12:56 +0000
Received: from LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd]) by LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 ([fe80::639f:86e3:3b7c:f6dd%4]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 21:12:55 +0000
From: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
To: <aconole@redhat.com>, <echaudro@redhat.com>, <i.maximets@ovn.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>
CC: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>,
	<netdev@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: [PATCH] selftests: net: fix spelling and grammar mistakes
Date: Thu, 28 Aug 2025 22:11:00 +0100
Message-Id: <20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0495.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::20) To LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:323::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P265MB6985:EE_|LO7P265MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d49cc7-6b4b-4f44-f34d-08dde677a837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|41320700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ucGv2gnCHH1CFo2M9TU9RdA5dkTfwjmmZjQtxkdylNIvsaZ5jGto/NnCdbS?=
 =?us-ascii?Q?FqsBrVyaD+n7l8FG8EODrvUa7qHz7DaY/yhiB3Hl/4Oyp5H3tX67t0K+8Dz0?=
 =?us-ascii?Q?XJ4RAbg6zKF+tWCGwaDpvVXm+CJYzKYQ34wKjQ+JL1nA8pnhU9vQlmYNjU8n?=
 =?us-ascii?Q?Fp6p0zWgBfBDbLUMj2oGFuy0QhpVne11ZYBHD3iWpsK4Km9OfMReIJwrt8Ke?=
 =?us-ascii?Q?0dO96p7gy+rSuq022QdbYlpYq8Gdtj9RNiVEfWCtICdJNJv3Yg7oeNgIVX8d?=
 =?us-ascii?Q?/fP7SL2f3kaSFZTLckwe1QTJJx4bV+/Vyo6NSrHWdiSz7X4IXvRjnwt+QWid?=
 =?us-ascii?Q?Dc2iVRdHKHQtmMl748h1u/sTjR8+6M0aXw4T9Nn9GHbQBd140jUyCUpQpEwi?=
 =?us-ascii?Q?r4EtYU/gTLp7dhPHEAhC8hPIDeSv8Ek8uhM5UFDXRvLF6YKFfBhXCCwQSD9y?=
 =?us-ascii?Q?Iu8CGRfI06y3f0ZksBwx+6+MtfkKz6CfuZN9jWteAbXGyItZKxZqpaIzN3Ik?=
 =?us-ascii?Q?fc1xqJSWwItHpw4p/2ppP5XiR68VdFXo93LSC0ubxRqzLw7B853CQXZg/TWL?=
 =?us-ascii?Q?lcUpbfi9h5hRTzpocyXMvDC8LyhxVa87L8YZGJKGQ7sptw9pBDp5zcJS2eMe?=
 =?us-ascii?Q?Ew/M5kKObcnya4cV7rTCEYwol33+D37hfA3wakWjSZT6keP5J1/vLoBnq4R4?=
 =?us-ascii?Q?+ZL6JWt7whteooIA3jhf2FILibMn4LXdvSkkSux8WuUSN+hMrGY/m8V5dZV1?=
 =?us-ascii?Q?Du0/PIjEVm5fX+wf6cGRahRpeywZBR9ezL7r3v2LZQr0/f+B6BpdSN9ae1WZ?=
 =?us-ascii?Q?ydPvb2ka5F7LP6cO1jwk3k37blcOyVaUy0BNPKCcOcrN9d+DrMvbk5fpvoN2?=
 =?us-ascii?Q?mKjHxoKNPAxGF6FLQl5m6KKkv/wme3jaJVop4wi8iIft89+BFyqSpez9oAPd?=
 =?us-ascii?Q?nM0ZgJhZp+50fPXPAV4XlPmPl9nKs6WGjnFlEyj5eoeMNHI3vNT8AVDglm7F?=
 =?us-ascii?Q?TU/vGmYWmnwKsYiP/T/0kh35GrKt+kiYXM8xil1C616fKf4MAMJC61uoHyYu?=
 =?us-ascii?Q?3N/qfGh088qATh6+0I/ohlttr18jA3pDIuOs6Pq4Myk5Zxf9sSDPBYOHuVTg?=
 =?us-ascii?Q?gvqFNlBy5eAtykLsTpn3wWKsGYXsjY135xsJjiYXl2kllyFpj+FSx3gFuFct?=
 =?us-ascii?Q?XtHL8CuEHYsRk4LzvBKPzejIVonB6HZgBHAuNpho7/3bAqcgns3mSAfiVqUG?=
 =?us-ascii?Q?PGg+db914UIu2OE5vyDAv2bwD9RvSaI7F3Az9RAkRFHqzA6godAGVDpLtfI8?=
 =?us-ascii?Q?hDhRmNQ6yZLuta2EpCp2Oe5rN19lqp8VcM3qIVzrPRfZq3GdgyewLXNFVfRZ?=
 =?us-ascii?Q?dICEOLtF9ov+RW2jahet3aNX3npGNfa6xmI84YNsaVzHGFrkaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K4X34X6ZhI5evvRTurCpTCrwcdCcKeTK5Rv9KclzwSQ2wfvosnfhlzhE6lDs?=
 =?us-ascii?Q?N5ZAbI4PVHkQyczp94gfOD2cGk1GvIskIWc0mWB0Y6hky3Mr159DdHpnocx3?=
 =?us-ascii?Q?U5blZ5f3A2NZ/O/8UU1Kcn3gJN3e0KQjI+qtPdyMoPAy4FRC01Chu1SX+JYG?=
 =?us-ascii?Q?gbBt1XRQcIH3GXrY47jI4GxSjhEu9dE6lmPIqS5ab4QeEap6B1UJ9iuU9OZU?=
 =?us-ascii?Q?mHX1l8nHdOl25R8MoVhMtXlGKaFtZ04xluNVIK5ve0MlbbW3A4LbcEkyvIp6?=
 =?us-ascii?Q?6sYy6bct/1de3N+1nvWQ/eZGn2rKE3mprN0PO0nQXtJ/E89hi5/7oWlicg5R?=
 =?us-ascii?Q?q1IFM9lKq/lV8i/gfOTRZ0rpTDvYTMlpDFuT5ZtRk/L/plqGx8ToMRqVe1s3?=
 =?us-ascii?Q?gzenKAEJiqsBFbqVZ2Hs2eb/fb3flLQCKI6vPRdSqmYQEuoj4sntRh7V5VAr?=
 =?us-ascii?Q?K6mKys87aXaTR6MfOPq2FQfw0MWw4FkbmJSwfyj8Tp04nBLwb4yLaML91NHk?=
 =?us-ascii?Q?VDEiZovQ9SqlRF3ung+UtN/pWdWqkLGAqXDAJ+oX6coFdZ9HPWxgX2R6q47K?=
 =?us-ascii?Q?scjy/833JW1juW+nwxWb2SADM5EulaINf3i79hmJDRTSCmhqhlphnHxXSr4P?=
 =?us-ascii?Q?f8L3HOiJ4Fv4+K3rs/Z6PVEMgswp8kr+4EMEwRbUxsWoLA0vuowLP1GPxtwz?=
 =?us-ascii?Q?x24AalyjahQzsps0tmZ849kFpU2ChEhonWcrJ201+DsWwR8XpoX3qJ3R4m9V?=
 =?us-ascii?Q?tEmXOIVz+aOAe2F4ej59KdK/rlikPWeKCgTrJyNHdRlQ2f9WOv+pSEhNW+kG?=
 =?us-ascii?Q?kdiN8soHwwWCiZvpm5fNdrfTv+iI/3Xu+1mhpSvY280yzxwtIbAzkXF9Fsry?=
 =?us-ascii?Q?00QKwh2x52OCCUjujF59zTMx/7izzq00QbtrhXAw0k83h99dsifT0QnoQxRn?=
 =?us-ascii?Q?XYpcwKGDKEP+7smV+q8Y4JD7zNR/nx0RmfQjh5l/DLDbxyUARq1IcwOELiq4?=
 =?us-ascii?Q?tLKIGAGn+iGkuXGLLRXt8J7YHUId7jrvnXvW7YszxQcFM+NKUfAivp0WciU2?=
 =?us-ascii?Q?zETnQVjOQPqWndzUEu0tsKxXG/CnTOjSOTIZvwwBAvzB4VayK6gQCPSl6ZFJ?=
 =?us-ascii?Q?FvIu/bs6S0CDXzHSRufnkHPTie34k/JudP+FU8hE4aO2RhxxYj45wFYYtVJ4?=
 =?us-ascii?Q?2eSvb8uCvg3C79pNFzkezihUhiBIAHyVLbA1khDNo6JNHlaqBZxFiwrTQvKL?=
 =?us-ascii?Q?TeRMxVu7pcpPwsowithaIdwsPoMnOpTzY+fiEI9qClPxKTWBWXYJLhQGXV7h?=
 =?us-ascii?Q?bp2aXjMhSaqwn8A9c5PTBqe1YzBKde0A4JFvB3brtdSunQ2W6AS1ugwyj2F4?=
 =?us-ascii?Q?oib3lbat2XOScCxRvSS6aAxtZ4rtjDRFsmFFKUwUnlTZXhX5z6wiL/nawL0p?=
 =?us-ascii?Q?6fXVgNdoUqNWZiMwrKKO1Zvz5vXbIlqfUDUYmHxZJtx7QtMBS6pgXUzAi/lS?=
 =?us-ascii?Q?vd5f1YFOMpedg4NHDcOq9rWfO6PTVdtNKILujnGFhLn2s5hA5QXUhE4059iK?=
 =?us-ascii?Q?I+iP3nxPjzKQ/d3n82JU4PA3yr+zgoGZoMj8Fs+U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d49cc7-6b4b-4f44-f34d-08dde677a837
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6985.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:12:55.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cc95de1b-97f5-4f93-b4ba-fe68b852cf91
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKSZ06ivdayoFbP+PSdUILt+FWkhRnGeUB50j4tKD8+M7Y4oid/k04H8u9q+apw6+7qPThxadsHR/JN5dTWZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7982
X-OriginatorOrg: magd.ox.ac.uk
X-NTG-DKIM-verify: pass 

Fix several spelling and grammatical mistakes in output messages from
the net selftests to improve readability.

Only the message strings for the test output have been modified. No
changes to the functional logic of the tests have been made.

Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  2 +-
 tools/testing/selftests/net/rps_default_mask.sh      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

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


