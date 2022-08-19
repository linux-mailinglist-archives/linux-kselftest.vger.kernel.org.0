Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333B45994E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 08:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiHSGAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHSGAC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 02:00:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264ABB6A1;
        Thu, 18 Aug 2022 23:00:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5OgPR006744;
        Fri, 19 Aug 2022 05:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EgNIyLr3QcniO2P6tXsW/6rD/5ThiwojYQcRMnRzzz8=;
 b=df1Bx1rz5pwtFCZqrdy8t3L5wkrnB2T8GWkuOqh74ZdsceqcJanH2P5I2M2Mji1hbmjk
 gDFwhpeINQz4kYVkjn7Fr1bprr1/mD2u4dJ6z+71d/Ah2dzAHAU6l9k7cNyS/L5bpbGf
 Jl+OAkUuASSsH9qr2qz3x0deMiDm/yvbjKaIgmK5vpxCEl5/E2P7dmUI5Lw4b13lPpKc
 Qa5LTZWjCx1VxN7rkkeAmE6VWLfscWgfIboUeXtbz/cP2ODcKfTa/Ac6UnlLt9GQKZIG
 EyjZ3Y3jnrJH4o8IpfHegUDw6y8IoXu/maOyg9PhMjaRefUBI9Zky2YHCvANS87WKZpu hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j24bk81h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:59:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5AwZ1005807;
        Fri, 19 Aug 2022 05:59:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2db7p17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2vMZRdwl8ospTcJERmNYNLnphI/+IfHgInclS+LkXwFeQ1k7NmdcsEkgghrkufmwCws9ew+aR2ikBHMVmvPtPljh5k7eU8B1WdvBk1z044svqgt2cc9ysJXOj25P/WVar7gsOglTWd+6gciLtK29O8CmLjclC3+ZiGk5vvGjRHIe2KD3XyIlQKN3BG09ACkeCUE1gvLwffRQiIeCIAdBq+O2J/25Dl2CkTOEJxqkjjKaQqxhqCtPThRC04cEn2McAWIaP2KXSHd6Hvj4Y1JTOEai+gMm2L8XckboguSJo55jGMHazxmnoGhyWrfWDKEVkzsBc4HO0prOn3DMomDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgNIyLr3QcniO2P6tXsW/6rD/5ThiwojYQcRMnRzzz8=;
 b=S2arLLu3JidFcwRAw842TRR7+vvn1GzseQ4wbdidz/3XFHX51RIjKA+a+HDj2thm+VNPdZcy/XeqhhWlgGvDANy7tlIxv+gW0ilaxqGZi2SNTpWi7rIdwXrD81Paxeh/hMz8bh5t7cK1XceTH98e3yqda8Y75Wze7AE6PvdjBIEE8LyD5bR3gyNrAdRL51+1I/2KI7k6Ih/q3A60U41Q9HWZThZXBdaYLThfeRvY0A2taHwnxw0qvkXO2gDMbC6YuDMlq4elIYW/jiogxUmdCLgZU/jWgOrj2Xh3ycsDcGafk1AIQr59OQxz5biiWWdDUl6CIh1ccrFIm4QXu3Jzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgNIyLr3QcniO2P6tXsW/6rD/5ThiwojYQcRMnRzzz8=;
 b=yrQCOF24/nPWUDwefx97LzhVr8wtefButN9pNunM8/GasIN6f1/DJ1ryK2OoNzqztnSr6yT6FBmTozLrRk7c/DD4S6LRtWNpLYyZby+g2oCjFVhHdspYI0OV4Bed7or+YHqtEMcITb8+jjlWZ3/20+enNhBfc2gsCSwS8X/XKpo=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 MN2PR10MB3344.namprd10.prod.outlook.com (2603:10b6:208:12e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 05:59:40 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b930:cfaa:ee64:f30f]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::b930:cfaa:ee64:f30f%3]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:59:40 +0000
Message-ID: <035a9eb6-01af-0052-08bb-81531f95b5c7@oracle.com>
Date:   Fri, 19 Aug 2022 11:29:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] selftests/livepatch: normalize sysctl error message
Content-Language: en-US
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Yannick Cote <ycote@redhat.com>, Dennis Li <denli@redhat.com>
References: <20220811212138.182575-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20220811212138.182575-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::36) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b7ae3b-9934-4708-bd10-08da81a8011c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VQytAFyS2kDzoSknnI6PVJo+XXwz+3dT+b9fmgtqU1w+Scibs8ELiXcoBVKeQpnP/b5gWHamUQ/PTezqy8tglnZrGZPpA7Bx2wRe9Vy752cg4iyrVTQUym6Hq1lkdpr/2YQ0Vjf3H+pV+yaRrs2tMcAvAmhx8WFnDv8Sn85bQ8ILJV1aHU0Rg2xrxxbQ7ZSrEDM1GeJAlYLhy5lJFZ9BPRZggjJQ5NG775jkiIVCKIOGn5Ay4BBNrd9sqP4+dr6nGR8M9KgorxxkH43N5b6wCCAkGVQcpThIidvSG7iSpvswX0LBF9ZzzEnXrA9f4TVjOSzxWtOKvbpfTXkEnEqp0uQC8dNlaxfp+7ZuE7kezOKkUymn40a1ee4foM95tfeuauLYxZrcNJWWXe6PFvx0d87zcT3NRgWJmu1sk5g4Ys7I0TAeoNqL0tDOyFd6TW65cQNXRzlTYdnc1hD+YQI03q4gWm2hbo+YNMEpLKbNxSz2hQo1JxdTMg+H7AYX2AVsYknzsQMoyVLlxETcurTmJoE2U3pNLqrur/BTfo+1ONXIcbpf8Wt12EwAAkbPdizqOX516jYowjhvQL5BuTo71eEQJz4i+1aO89gsMLvrkZdoLxTlmw1lFTHgUUArXMX0e2WOrmFqdkkJyPpa5fkhkn8T4MZG7zXIsxDvgxVcKan+djq+fOYchVVLXf8tt9DyP61KQaYJcgIIPWHb0qA/bY+at73lhsmXxe6/haFNCM51M2Ord229S2BbdkZZlc8lqHU3GmnlLIayDI8erKvwDMOJir8snMNYH+Ow7vQhUBEnIib3nmYkKeh8XQPFoatDOWcJoi2J/v1+rL3ObZS/USRC3iE1KKptkz+jCuJ3UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(376002)(366004)(39860400002)(186003)(44832011)(41300700001)(5660300002)(8936002)(8676002)(2616005)(54906003)(66476007)(478600001)(66946007)(4326008)(66556008)(316002)(36756003)(31686004)(31696002)(6666004)(86362001)(6506007)(26005)(6512007)(53546011)(38100700002)(83380400001)(15650500001)(966005)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tlZHR1WVZxcXVWckVXeEltZ3hPYkU0VGcySnBSNmNWS2w4SVFCZzJQLzd4?=
 =?utf-8?B?QnZ2MzlaOU95SzVCS0FoRERWai9hZDlCYmdaZ0lrVHFvNXpyeXJldmhEZG1v?=
 =?utf-8?B?NmpJT1c4VGR3UmFUU3F6cGRpb1NrcXdOSXNDelBEcFkwWndNQ3ZVbWhwRmFw?=
 =?utf-8?B?Uk5nckQ0RTJOakJubit5YTJVaDhNU1lDZ0tVbTJmejV3Mkd2eVljdHBkR1BV?=
 =?utf-8?B?N09LRCthTGtQRGxVdzBGb0JSRStqZnJVQm1odWJEeE1QcFZNZzlCN3A0aDUy?=
 =?utf-8?B?NFhLSlhoeHhvbFpWc2M0TENTcHlFQ0s3RmlEdndCK3V2MHRERWk5TWxORThl?=
 =?utf-8?B?NDhrdEw4VWVhMFFzVExEQkZ0NmpGK1BzRUlhUzZ1RjN1OThzZjF1dHFKTmtH?=
 =?utf-8?B?MXdQYXpTOXcrOVovQ1NpQzZ3VGJPTHlZZ0tYRWtJbmNKSm1TTE13MnRkbWVG?=
 =?utf-8?B?aWVYd1FlQzZ4TVNPNnhyenh1U3Rhc0t1eWpIb212OWRlcEhYREhBQ2VmNUVD?=
 =?utf-8?B?SGxvRnEvcUsyYXhZOVJSYUVEUVlWT1VBRlNNdGZ2QmY0ZDh5dE9sZUZlUlJH?=
 =?utf-8?B?RWFFdHlPRHgwclJmb2hVVStRSytrc0VuYk5Ka3gxU1FIcjhnc2F3bWNNT3pu?=
 =?utf-8?B?dGhXb1F1ZlIxOHdEZkR2cWYvUTRLQ3lDaEQ2cmQyL3pRKzR4TzJGQ0tsbWF1?=
 =?utf-8?B?cVUvSFJZNmNxREFBekExWGpMUzgwQ2Rxc2FoS0JhMFNNc3JxaFh5RW5Mak1S?=
 =?utf-8?B?UG9uZW9mcHVuM0V6cTJlcW9pNGZ0aWI2c2ZWTjd5bjA0VEp6VUNrMytjSVA3?=
 =?utf-8?B?c1VKVVI2VDhvNUorRnJNN1FCYWdXc1Mrc3BvVzU0R0h4UnJBVGM2RGZhL3V4?=
 =?utf-8?B?c1Y2NmF1NExiam0vMXJMOGk1MnY3Yll0Q1YyeTUwWVNDY2o0bXpXRmJibmty?=
 =?utf-8?B?Nmp4ci9rZ1FWYVN1QWFxNHEzK1gvTWFXckpnWU9qTHNzYXNMMktaNWlsSHZR?=
 =?utf-8?B?Ync3QmdxdnVMS3pnNUF6QnBKUnlkMERnOVF4RkVIa3dtTDBmdk5ZYlZXcElD?=
 =?utf-8?B?ZVlzWk9uYXU3UG9WSDArOHR0SnA2U3F0bXRpdVUzYnJJZzdCaTN0QWVUYklm?=
 =?utf-8?B?RnNHcmI0NjZqTVpqdEUxc0k1RnpBWWpSckxJRmU0b2dlb1lvclAzU0lxMzVn?=
 =?utf-8?B?ZmN5ZDdlZnZ2alppdVNTRVVtdHlrcnQvZCtEYUNWV2hoLzl6Q3I4TDhiMWdF?=
 =?utf-8?B?bmFsd2NTZHU4ZTBqcGN1Nnl5TWZYTGJhOUlEY1A1THl2WEZycFNYY2ZucXNL?=
 =?utf-8?B?dnMvR252MnVjeVJ5a0ZTVXc1cU9MUnZXK0ZKOTduUU9KUGlwWElITzZDMERK?=
 =?utf-8?B?MTNBaWx0Z3p3eFRxQ1NRSEw2aFlKU1BqeUd4ZW8yVUJZMWlaNDJaMkNTdDZz?=
 =?utf-8?B?QTB0TjRtcmFGNDlWZmZ6b3Z5K2h0VVN3RlE5dUhIbGR3MFNVMHRyakExT0RI?=
 =?utf-8?B?VlRrNm9VR0lTZEVWdkM1RGlGdGVBNVNzMElOaVJaNitNR25TM294YzIyK3gx?=
 =?utf-8?B?Ri9PbXlNUDJwOVYxMGNMR1ladzc0RmtQenc5aGNzdEFTUVlUZUlUbm5IcHA0?=
 =?utf-8?B?WHVaRHB0cWpBRUZnV3VjbzRYM1RNeit0MEkybGIyZ21Hb1dXcWxFZStqWllC?=
 =?utf-8?B?WnBNNDE5cTZ5RFRUVkZ0SnBsTWhwcjdpUWhWWHZhTUF5TG45OGhXWTg4aGlS?=
 =?utf-8?B?cytqSXJFSDFrVjRRMGJvMFZ0QUpEMWw4TlY2M3lPRk9CVFVVa2hXTUJCN1B0?=
 =?utf-8?B?M3pWaVFIbWdXZmUraUhkWG8wbmZoV2paRUJFQ25TQ0trRnhTNGw4c3JMaGVx?=
 =?utf-8?B?bEpVWDZUaFg4ZE9DMURmckNIc01uWWczZ1RWVlQwbVhYQWhYdjl6aXZOYWpZ?=
 =?utf-8?B?YUdQV04rcDFPbGIzK2xEa0ZVbjdObjkyZDNTbHVMSG43TmRsMGdrUFdGV2Rt?=
 =?utf-8?B?cEZVelN5ekRhcUNITkQxQXZyVFRIdnBIMGdWNGVRMVE2cDZxVmxwVkRYeFht?=
 =?utf-8?B?R2JvQVkvcEZyd2JDNXBqVjVPa2o0Q3JOdmFPbHNlNk5JVDNhREZBUWtVdWdC?=
 =?utf-8?B?RkEzNVY2ZnBoZEllUk5iZ3ZIM0pSOHhXeGdxeUFkVVNoZEFKT3RSWVNIUExK?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qjc4OFVUQ0tMTjhTZEhHSjJQNzQwUms2dS9DVWJ6TE5FYkloeEJEWUVKWHls?=
 =?utf-8?B?dXhXdHowSFRGcFRTTkJ6RjhBRWpsNWw3UHI4K3NIVVhwa1FuSjZhcndHZXRj?=
 =?utf-8?B?WXdLK09wVjBPUlpJY2trQVB2bFpjV0FmZ0pydUdmWHN4Nk1tY01aRWJsSFFT?=
 =?utf-8?B?cTdnRmswZW1ZbEtTKys4alhjQTZhTkpRSE9FUXBIVlBDWkYyb2wzdUlUZE1V?=
 =?utf-8?B?eUE3MkU0VURZcDhEbVRBM0x1ZmZqSHhNc0pjTS91cmRDRVZuTXpMaDc5MzVP?=
 =?utf-8?B?OGVTcUQyc2QvbHNWbjBVQzNVci9nR2tuZUxNYnlhT0ozQlFscVY5YlZIWmIz?=
 =?utf-8?B?Q2ZvUlpMTTEzdGFZYXBGTURpdXpNblNkekpzdlhZVDk1Y0RzQ1oyOUsvWlNl?=
 =?utf-8?B?UGRxOVdJTHl4MmlzbzV5TlFoaU1KNnVwUzJuM0VIOEp2SXNjTjZINlE1VmNa?=
 =?utf-8?B?V0Y4a1o1SHROcFZFU1dnKzJmb0dHc1RGRE9MUi84ZTV3d1lDSUF2QWc1MW43?=
 =?utf-8?B?RXJPK1pWRGNaNlFwRHN1c3ovMDk5UWVZa3R2cTJGQTROeldxdmhPZDBMUHJa?=
 =?utf-8?B?cFFwT2FOeUFBcG5ZVTBSK3Yrd1dCOTNxZE1YZ2JiRVR6WjYvNWhMSlBvQjdH?=
 =?utf-8?B?Wm91OThMS1A1SEpGc3o3S0NzeGx2Ulh4djBwVnY3RFJqTi9SMnQyMFFUajZX?=
 =?utf-8?B?NU42RmpQUU1tZjl4cEtOWndEQVlPNFRuTUt4NUtBdzZxMmJLZ1dlN0J4LzFF?=
 =?utf-8?B?bm14anZoQ1FrMkllSFVwT2lHb25idExNL1Bsb3R2amlIRlAvMHgwdms4Ulk3?=
 =?utf-8?B?SGIwNFJDaTMweEdGMitCcWEvQm5VaWQ4dmhNM3ZwUVQ4UEMxTTMvcGNkNkZS?=
 =?utf-8?B?RHVJMFcwbVlFRjJ6WXdVUXI2TnpGdkVGY3NiYkkxYlk5Q2ZkQy9EMTRIUWgv?=
 =?utf-8?B?bEEwK0E3V25BQm1LbTZvbUYzbmlzdG9jd29lRjNJaFMyTVhBODEyTko5SVFT?=
 =?utf-8?B?S3lvWWFnWWFNLy9iSWswRmhZVWVkcGxuc051WlA3WjdyOXdXL05JekNDaVVq?=
 =?utf-8?B?TjhYWFgzMzVSM0M5aEV6L1hIRURIcFdvS3BzNnVoSkpEZjNCRVdneHZ4RHB0?=
 =?utf-8?B?MWtwenFkOFBwdFNUeG1US1JMQ0FWdzhtbUxRaHAvSUZUUnpZWHB4Q0JNaXYz?=
 =?utf-8?B?TG1NMGZwcFRORFNodHQyS0JsQktVY2pUOHFZRGFybWFIaVl5d1l3clh6YTlH?=
 =?utf-8?B?MzdRZTAvQktqOW9ILzBvbTlTSm96Ty9Hbk1veStJcnBLbXRmSlJGbHJhdkhz?=
 =?utf-8?B?VzFFM1RlN1dGWTRtdU9IRmNoSnM5bDNyei9SVWg1cVZSbldFQzJpazFwYXRT?=
 =?utf-8?Q?PPTUHb2ygHXPyruKi+ncteTEbhlLmveo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b7ae3b-9934-4708-bd10-08da81a8011c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 05:59:40.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x00+PXwGeKrJmXAKbE20pE31GTI8NYYeBLRPnOHHWaZM4SJVFrESo5NGW4Em/Sbk4EsMZn+/tbG5Sbj9uAzee6x3wo+hjAYFMkIlauJP6/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190024
X-Proofpoint-ORIG-GUID: zhSnQo2vv88dWJSjFc40hovLt1haRdZ3
X-Proofpoint-GUID: zhSnQo2vv88dWJSjFc40hovLt1haRdZ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/12/22 02:51, Joe Lawrence wrote:
> The livepatch kselftests rely on comparing expected and actual output
> from such commands as sysctl.  A recent commit in procps-ng v4.0.0 [1]
> changed sysctl's output to emit key pathnames like:
> 
>   sysctl: setting key "/proc/sys/kernel/ftrace_enabled": Device or resource busy
> 
> versus previous dotted output:
> 
>   sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
> 
> The modification in output was later reverted [2], but since the change
> has been tagged in procps-ng v4.0.0, update the livepatch kselftest to
> handle either case.
> 
> [1] https://gitlab.com/procps-ng/procps/-/commit/6389deca5bf667f5fab5912acde78ba8e0febbc7
> [2] https://gitlab.com/procps-ng/procps/-/commit/b159c198c9160a8eb13254e2b631d0035b9b542c
> 
> Reported-by: Dennis(Zhuoheng) Li <denli@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

> ---
>  tools/testing/selftests/livepatch/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 9230b869371d..d5001c9eb72e 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -86,7 +86,7 @@ function set_ftrace_enabled() {
>  
>  	if [[ "$result" != "$1" ]] ; then
>  		if [[ $can_fail -eq 1 ]] ; then
> -			echo "livepatch: $err" > /dev/kmsg
> +			echo "livepatch: $err" | sed 's#/proc/sys/kernel/#kernel.#' > /dev/kmsg
>  			return
>  		fi
>  

-- 
Thanks,
Kamalesh
