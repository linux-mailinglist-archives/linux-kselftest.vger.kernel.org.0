Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F5766D7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjG1MnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjG1MnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:43:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD09187;
        Fri, 28 Jul 2023 05:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci4HtpYFoAtVo0ZnVDUQkepN7r3OpWf2c4/tuXzYCtcJBzcTk5Jyyg4SGgepxwyoeIYYiblXkd31ir3wdc+4xOTf1jKLnMeuy3lp3rDW4/A2FPVL3t3NbWkSvQt98SfHgZHyytJjN55miiLHJttA+JuHNk0cdd9howAeHqmuzAYbtTnv3PyO7IQgeNw7aVgRFUZ0kYK2iF++j7GtD0vqbauO5ADh6fSQ196Xf6PQ9+03SjSM2zpG3LFJMezekovWoQXfrJYWM2tWPfTxTJR6dJbgRZgg6ZrWmMYPwv9mg9sIWrHQ6dtYK0waH0W4Ric2ndXnsDKtjW3OKTytE4mbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWJEahw2gNltIaFWg3pF1dNagj/eW4z5OOERlmdh6c4=;
 b=hHjWYLo6xXrskPiSOC+xcLevGCp+LxEsWuchQqTWD1yJzf449n6hSJ6NZqF9ZL11Axdbm0NOj7wIuZmUsIq4ArvXUSATEeagG58TsL4tTTXXgAdi04qm4g7iO/9Rcmk/Pxfz+Eqza/A3oCl+wWD8RoIBKkqODSECWBpAJ2c6W8cO/bz8GikyjTZp6MSl31I3/cv+8wdcIbZzCJOl6JfJ/NbV8mP0edqeDd4mIudJ8GveDAtB/eHyBCJnm/hWU/HoiH70wpiQbawrLJRX7w1NGv83XZTKZJqZMoGFqDreZ3kvBSz36a3J0XWYT+IWM1mq0sv83huYzm8nEbMg3tU3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWJEahw2gNltIaFWg3pF1dNagj/eW4z5OOERlmdh6c4=;
 b=agyxMWZhsTk0CSM61pWaEImmqgHlI9aam9QAi0DWalH+u0NfkNU6tjapRw5yTVJHOoIhGSfI/XD7WlOKn04+luT4speoGb7VKAHkrrU7dtKXUDlSWn6zAFBJetrTU+k55WjDnmxdsgi3s4TcNquUdzgVS+SFL9gYpZf1dh8wk3+bEwrvXwiaJtrVgSkNsnBgHJL4V9A2QyJhY2uhSIjTCEWhjw1u362Ul0WUUXDvFX1NA6HY3vHDrK3A34ggaomT736PGDwbfimIlJb4SesghXhPtyOiGC+Vsb8HFaQSyDSTyn5vq10lCx3IyZyLwJ0EQpDAFnrkIktLjju+ukgQ1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:42:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:42:48 +0000
Date:   Fri, 28 Jul 2023 09:42:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, alex.williamson@redhat.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mjrosato@linux.ibm.com,
        farman@linux.ibm.com
Subject: Re: [PATCH v11 4/7] iommufd: Use iommufd_access_change_ioas in
 iommufd_access_destroy_object
Message-ID: <ZMO3xTrfkeWQ/a6N@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
 <f9fbeca2cde7f8515da18d689b3e02a6a40a5e14.1690523699.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9fbeca2cde7f8515da18d689b3e02a6a40a5e14.1690523699.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8a9e55-e957-497a-eea9-08db8f682610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIb/qYKbfiJFtFBxIKl4GipZO/BaSHoephsC7akibBaTUgUQAq+kEP3eH2NiqhtVOeZnJpwNvevV0J2bL4/7Jg/zcGpPaw4cFgCzAH/ew57Yq7IqIYPxGXsfA5OL76rgP4y7PlgIJ2oXJpUsR5dW9VPoQ9ZG8lGouvM2lB9DA3Z7bkQd4reE6WLFS6eMi/H9aFgAI1agHXq2n0Qq3sG7ygMrEOyvRHOkTDGTpTFd+nCamhAoSh85ctZ9MWKMgazJNonyg+sAbwvsYp+WGZ3Vb4DdA6iNGPrEF1egANyjMwZB6rPcTZkpeJGo6kCSeOA8njnIAZOVUgq2RvMIwGkc8AX8O/1lK1UHd723Eay+VX+47EW9LmVYWfbtuoYoaQ/tDBxVgOFqZia/dPTx+VxHz96440ADd2yxd3FsT4X404oOroYPOL1JAI0wRQnIhU5DKnGaH8eTvvAGI2a17j4HhEMzHaXRK3LPTkatUEobL/o0SSZvhE1FlVciEmv+vaLfxHq3s0vSq1PFE82w7jHZ++FZb0tk5wu56Utn1klqVYteUcUpEDLiC5stBSs96w2a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(4744005)(2906002)(86362001)(6506007)(186003)(26005)(83380400001)(6512007)(2616005)(38100700002)(478600001)(6666004)(6486002)(66476007)(36756003)(37006003)(66946007)(66556008)(41300700001)(6862004)(7416002)(6636002)(316002)(4326008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQ6rNBeM8nEmGjWxQAHxSTQhMZ4pw/RLSBFSd3QlfvY+taxBGOwuWQCDmcPK?=
 =?us-ascii?Q?H4BBvzA5Yi8apcGBO/uhDTVxevUN3DN9sjCi/b0YarphuNN7L8tVUd3xishM?=
 =?us-ascii?Q?sd741cZu28bysl1OZCyPTZlgr8pgiWIOcy/FxRcqdABVHIxEjSzwnwwuS6kj?=
 =?us-ascii?Q?psegZyt9cf7pJJtetQNL6HkvB9Hbyep6WUZtyKGCRfhhCsTM8ZwPRUVW7K6z?=
 =?us-ascii?Q?a9ERuF+RxOE3AUuk8tcuFdQ898MFgYzyVsNC+bFz65C0Zi7Qojne5tjkbfy4?=
 =?us-ascii?Q?GoDxyqpzv9gJ0pFwTBb7KZQmlIhyiFD0OQch2mvT6bbgIRZlISJRwKMXkzOL?=
 =?us-ascii?Q?Q27ecP5iOsiX3wMxQsGlkk8+EvDe4AhhZsGVbZYuYKzdSGTIE67K32gzhcBb?=
 =?us-ascii?Q?Mj/VonQidjw3wdMrQ3swXkmB4cIleDHKIiHWnywRpFHrhY08j2tDNc93U9GN?=
 =?us-ascii?Q?SkXWpbg5v3zUOhkZ+55IhTPFgN7bQSAIYf6a4W073DOkNYZ8xUBLPJqUsiAM?=
 =?us-ascii?Q?MBGdQDxw+JzmVOdkXFByHzhF9kuZ/fjBgTrE7m2a4A4dBnhCs4iM98xwA26k?=
 =?us-ascii?Q?uPMCdcTedG9ml5vpxuEI2/4U9knkAUg0jGBrwNUkLUDRA7sRkxc0QNIImd/E?=
 =?us-ascii?Q?wp+WtoFetxXjDN1OIoee7E5sN5FcRCuLtglOZbqDLAKeq2m2UVbCJskc2kbj?=
 =?us-ascii?Q?UEzStLEe2b9+zCrZGvWCnHB1jJfzsuJHeIKrHcVLw2URkWOQ+ZFMQ+T5vxDQ?=
 =?us-ascii?Q?2PzyuYDNtntd0sie3IpW3NgM6lMj5FGaaa8MZPzYMPCen04uOLka8AXi/OQg?=
 =?us-ascii?Q?Jv87xJVDMLiTi+QHUp7rhL4TKGGSlj5361Ba8AVzbycFFqEgVkjN1c+C0fp0?=
 =?us-ascii?Q?YsHp5r5r+qDrRcHcFxqkms40oUx87uf3ojxim+S40vCjMhQdejDlLhekUdYg?=
 =?us-ascii?Q?mwase4HbqsjiJEvitLR97BzOsbEcHZChSmKYnyWv4lukwQoJTKx7npqJRs69?=
 =?us-ascii?Q?BrxC3xnYU0vvUkwmzvps+A5Gi/6aE3JdZQkxZUssFHMTMlmeJTaw9HPCCjfM?=
 =?us-ascii?Q?Q/5OAm1xg1GlHE0uIDNjm7exyfTKAq43ZE912YQsS4r31rdASCVPeX3BLVXY?=
 =?us-ascii?Q?L2I5ZqQpTo/4CL2Vw4DrBOpjUcIcEjoAjU3Fza8pH6FE5DlZVy2dA7s5zyTo?=
 =?us-ascii?Q?AUyz0lspsEATnIJEGFfnvAjh8W2dToCST+XeF4f2nuoPMefip40am9yPVJZy?=
 =?us-ascii?Q?VUVO14oAe5xfDXWnnj1fak1v5gKbFFQNWWmR4J3lLtp0GnwfQMFNipafzDGO?=
 =?us-ascii?Q?n8k0TXgSSHbG3eXqXvN9c3MNIV59IMubA5LCuXsesj6qGW6qavo2YlDv/k4r?=
 =?us-ascii?Q?f9HWt0iq24Kmv+CV56MxsLJgVAdyYpzP0aCrUdEjErXnnenQacrWUHRwu3yh?=
 =?us-ascii?Q?JEpnBJlfpcWN4Y+jDESxHO7G522XiWfWQsGxdqBzPXEnFXrbZ8Hcc5Y73h11?=
 =?us-ascii?Q?G27GVi6wvcnHO1lpI3V7ysjOtOLWDH/2fCZT2AlYR+N9QDsbjTrVTXOORolo?=
 =?us-ascii?Q?KL7/KQg8tXnUHwU7nM1IULCzA9BBF3l5O5zMqLcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8a9e55-e957-497a-eea9-08db8f682610
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:42:48.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/jXrLBR87p9sHDo9JU1i7M+hzV/z/Djl3PI3K0G4clPZOHeYPZYjZa7xjNyJ80o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 11:33:26PM -0700, Nicolin Chen wrote:
> Update the unprotect routine in iommufd_access_destroy_object() to calling
> the new iommufd_access_change_ioas() helper. This will reduce some risk of
> race condition with another concurrent iommufd_access_replace/detach call.
> 
> Note that the behavior of this function call is changed: a WARN_ON will be
> triggered by a -EBUSY return code if there is another ongoing detach.

This should be completely impossible, at this point the object must
have a refcount of 0 so if another thread is concurrently detaching it
we are already UAFing.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
