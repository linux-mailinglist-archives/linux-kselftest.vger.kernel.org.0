Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891A197443
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgC3GKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 02:10:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgC3GKh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 02:10:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02U68KOC009127;
        Sun, 29 Mar 2020 23:10:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=P5YWrf7dyiKQJAd/53OI6QaWl9Pia9ar2hQISqKxhPM=;
 b=PpM8iTephs3QL0s2mILh+DEUsWG51FSf9cy0ZyNcaSbN6gdhcSc1MKnIB0dzKxecZeFF
 zEGCxTNZqDrPWcTJm1t8Apu23b54apeYluhKAxnRoyK/gJRVhk+G/KC9SzmTISc/ERgQ
 pULdzzJhRCnxUpeKIR+exjfUDr+Q12bSF6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 302dw6xbd7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 29 Mar 2020 23:10:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sun, 29 Mar 2020 23:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1kVfJ72fy7CL+WA9W5Dtlr/o2+uQOt2QqI+lY+dnpiW7MKwgwmZeGjjzt15E6lSCgIs3xipTW9tiu0JbHZTt4kTEFKyQiNUxu+B/30drm4xek1hZT0k0Dex2ClJk5Vt2cAAED8HorFx7lgG+k8xsE0VHxhGkCXAJuBQZjosWw/TYWHUXaJXWuPJ/Wi0hM6iDfl3I+FzXDE2kAscxubBsE0g9Aiyj58UMupyPe52dAPWX0eAdJY+eGD1Irc9/gz6TCdOol3dhPyedPHl9AXmkqnagkwJ2uU/lBEoSy6JJbz/X5ZOBft6MAgWc8flepxr2n9qjPdcY6rhi8dt4hxuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5YWrf7dyiKQJAd/53OI6QaWl9Pia9ar2hQISqKxhPM=;
 b=C00iYywmBb6BCVVU5eW20LR0jgSjahWZcq7dW+CzJwsbp/YiTqM9izgI3P3TrrAhEdR5B/ZA/yQnjtimKELBVMBP0bobLe2h49m2xNhuB/XrTVPvPYLwJQRWvGKo4TLv3bxTE3z7QlsRe0MFS8OcgPr1dOysaRSW56yN9AtdTnZNcohn+jFxg62EdMliZX9BSGyWXGNEKsv29oJpgp6ThsbQuhsel+IgcEYjoUFOmj+BoR2gq8lTc92HK+bex8kqNudiBNGyGj/l0CokcijbDbw7C2F4fbyHlENKjFAiYN2CW/WcZb0IWBNWp56h++USHvLuWbSdkix/f19JhtDfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5YWrf7dyiKQJAd/53OI6QaWl9Pia9ar2hQISqKxhPM=;
 b=Jd5EeN4L56wiFsMX0iqHcvyyVRd15kbeuUXS5jTDdYW4D6ZXWJyGA9t13hxOSZ1DmohHdUMKT6rjvk6CYqJHjd1BK/s2457zzFhgFc/mAT/ISYXZp8S0LKFZOP3AS5fiOsDs6+ZyNTRyVEDCER1HySyuiKuY8XzOmRp1QveQbzs=
Received: from MW3PR15MB3753.namprd15.prod.outlook.com (2603:10b6:303:50::17)
 by MW3PR15MB3788.namprd15.prod.outlook.com (2603:10b6:303:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 06:09:58 +0000
Received: from MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::3517:e69:6e78:4f7c]) by MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::3517:e69:6e78:4f7c%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:09:57 +0000
Subject: Re: runqslower build failed on Debian9
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>
CC:     <linux-kselftest@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
References: <60b05d23-6352-b978-3bf7-5a86466bb297@cn.fujitsu.com>
 <c1025a74-1d80-5127-2b0a-87465d3dbcd0@fb.com>
 <84a70348-62e3-728b-d934-28e902d40fd0@cn.fujitsu.com>
 <da95b852-e556-1b56-42eb-b97e1826710c@cn.fujitsu.com>
 <a2771f66-b7ff-f320-dbd6-0967c189834f@cn.fujitsu.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <a2b1a025-6a70-c3a5-fc19-155f0266946a@fb.com>
Date:   Sun, 29 Mar 2020 23:09:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <a2771f66-b7ff-f320-dbd6-0967c189834f@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:104:5::30) To MW3PR15MB3753.namprd15.prod.outlook.com
 (2603:10b6:303:50::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:51:fde8:f2bb:1332] (2620:10d:c090:400::5:5130) by CO2PR04CA0200.namprd04.prod.outlook.com (2603:10b6:104:5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 06:09:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:5130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d509006c-ed53-45b6-e172-08d7d470f8b6
X-MS-TrafficTypeDiagnostic: MW3PR15MB3788:
X-Microsoft-Antispam-PRVS: <MW3PR15MB37881D5C4D1ED2A7507460BDC6CB0@MW3PR15MB3788.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3753.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(136003)(8676002)(36756003)(81156014)(478600001)(66946007)(316002)(81166006)(2616005)(8936002)(66556008)(66476007)(2906002)(6486002)(54906003)(52116002)(53546011)(186003)(6916009)(16526019)(4326008)(31696002)(86362001)(5660300002)(31686004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdQEEVhiLqERQUDBoM+tKR90tFlHrtUY5UYDex8huRlkQqjfetS2JqI0DQZjF2GO1QcBnAsFtZrkuI5tw5TWYBTW806MPNzaSIpfsvki4mxZHfFjyaf9M3wupNj6yAGoX4TL5iDXM7DJPPBzmpPQMfhw/p1lJSXKMaMLJ7h0uFukayeoXm0w599fmxzWcvbIqJvfWG4+MDHzj+rQqrY+ZpQNj8njxfj+wpdrwtu/zi2jIpHl5X+MMkVcszAzyiz7FSndVsjntfwvM9W+DDom/IulnbVx6JGzubm2KC+RjgYMeWLNGMOj3hgvuRIa6emlcxeZoioOWr8lSo1eLX+i4AOcUlsG4xtjeziEJj18zNtawRlqFqS2cKGbo3pXvMqNoKhdw+zFJrzKOQdnPB1agU8KklsmARFYL7JlZwyEL05VsFvfKNwEwB3UdBVCzqTU
X-MS-Exchange-AntiSpam-MessageData: QOngdz2MtNWF5+QcottyKkShOcf8u8xGc8Sq6Rk4hujpvTMeLZQR1+CvQBvtbNQZDZH1Ip5gc/uMOOOWsgMwLReaigdTXI1nMsjo93BCIl1ALA3jFBwJSB5f3GZHgnFdMcLnBuQ1M/3PbIQf+M0X700P57hQ1uSotexE16fLFDr/+ADkNTd1f6BD3wg3KhRd
X-MS-Exchange-CrossTenant-Network-Message-Id: d509006c-ed53-45b6-e172-08d7d470f8b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 06:09:57.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdQnFaMj5tmwUFA5WYihIqaUvuUXIZhmb6dDJIsVvgQu2f1l7UI3d0kyAAeTHlTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3788
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-27,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003300058
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/29/20 5:48 PM, Liu Yiding wrote:
> Add attachment.
> 

Your BTF seems to be invalid. It has struct perf_ibs, which has a first 
field `struct pmu pmu` field with valid-looking size of 296 bytes, 
**but** the type that field points to is not a complete `struct pmu` 
definition, but rather just forward declaration. The way it is it 
shouldn't be even compilable, because forward declaration of a struct 
doesn't specify the size of a struct, so compiler should have rejected 
it. So it must be that either DWARF generated by compiler isn't correct, 
or there is DWARF -> BTF conversion bug somewhere. Are you using any 
special DWARF Kconfig settings? Maybe you can share your full .config 
and I might try to repro it on my machine.

But either way, that warning you get is a valid one, it should be 
illegal to have non-pointer forward-declared struct as a type for a 
struct member.

> 
> On 3/30/20 8:46 AM, Liu Yiding wrote:
>> Something wrong with my smtp and this email missed.
>>
>> Send again.
>>
>>
>> On 3/27/20 11:09 AM, Liu Yiding wrote:
>>> Hi, Andrii.
>>>
>>> Thanks for your prompt reply!
>>>
>>> Please check attatchment for my_btf.bin.
>>>
>>>
>>> On 3/27/20 4:28 AM, Andrii Nakryiko wrote:
>>>> Would you be able to share BTF of vmlinux that is used to generate 
>>>> vmlinux.h? Please run in verbose mode: `make V=1` and search for 
>>>> `bpftool btf dump file` command. It should point either to
>>>> /sys/kernel/btf/vmlinux or some other location, depending on how 
>>>> things are set up on your side.
>>>>
>>>> If it's /sys/kernel/btf/vmlinux, you can just `cat 
>>>> /sys/kernel/btf/vmlinux > my_btf.bin`. If it's some other file, 
>>>> easiest would be to just share that file. If not, it's possible to 
>>>> extract .BTF ELF section, let me know if you need help with that. 
>>>

