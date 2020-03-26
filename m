Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20DF194922
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgCZU2z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 16:28:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgCZU2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 16:28:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QKBIIj005187;
        Thu, 26 Mar 2020 13:28:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vpEY5owUP251CpMVMs6pgESngCoQ1uY806QGZ/JvP7w=;
 b=IMl0L7K0Ypk7Y/een2105NuSulm216r5POMwsVPL0YxwJb+2EkZpaijVQsrNlP/fbLOh
 e8Oqvhcs3LMhSnTlsivMGfWCpg6RbUEP/IrkOesC+vgK8Oax2ysYdbUD2ezrBU1EnTLc
 rumxqnbVNVBcebShoqtiTJ+ywxE2fTXMdww= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xpah0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Mar 2020 13:28:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 26 Mar 2020 13:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eubu+30euWCH5eiv8iFMlzVdOOqwnuInc9rvWW2+S1iWHrsL0b0UA/IVHRxosn736oDGarQ9c09ZCwhbzp4VMZiEzYt+ym+Hkl0Ko7wHcYDylU2E0vzNPXXjNWk0v+CfnnesYJYniYkH3TMe/9av//bXcORaQ3/uuKEoL5jeC4bv+NRY4gZT/GOFgzLYDNSVHGJRgRiQmaTBHY14Gv3qSy9iCKx31iHXHD0dFEK/LMjgdyCmOLtMVDwCSlSl0ULJ4b+xRYji09iHanJRhoG24KqAGIGuFwaIfeJRgvWKGFZotsjaD+uOfR05DuLnfus4BeX9h6icZcLv73fQ8fsSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpEY5owUP251CpMVMs6pgESngCoQ1uY806QGZ/JvP7w=;
 b=WzG8YPdJqQqE3rd9aiTGaiOOsKoPpKscWZlmCobELRP21OeZ62EyYENf3cs6YFYO8xGrrWMR4umD5APKu1NfdrU9s2yXUoW2AtAlimBjS05XfdnVe2wRD+TtE2ufDagUbdc/7KE450OPlKS10yBCFqC0/TxHdmxCiEyxGCwpI6YaTRQzqsl8DwKNXMVEEqiSh+RhpQBggajC/bbs5l/LolKxCa82F+pc7iGW5+gOCSN8eJezKWRc+N/NTWr+kAyIoEyaP7oWqi5ULUrzue2C2m4vEYKU8UZGBy0bTiUy2+S6yQiNnn/bLgDxL+d4P1TUzZs7e1ip4VWkTiFJhY4Sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpEY5owUP251CpMVMs6pgESngCoQ1uY806QGZ/JvP7w=;
 b=WPSm2evOcf4aggHKM0s3tT3FMg//zpCYB81jkYgNhncpmC1u4skKqVCBWPal4IvhLPBTWO/Vf0KN0sfNrS7FnpodSgLq07OVcbba21VPDlRBWP++Uk/vzKmDW0V3jed6kVF8VQspxAGFs3PHAgw1REcftwFqgue79tmb5NDDcWI=
Received: from MW3PR15MB3753.namprd15.prod.outlook.com (2603:10b6:303:50::17)
 by MW3PR15MB3753.namprd15.prod.outlook.com (2603:10b6:303:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 26 Mar
 2020 20:28:48 +0000
Received: from MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::3517:e69:6e78:4f7c]) by MW3PR15MB3753.namprd15.prod.outlook.com
 ([fe80::3517:e69:6e78:4f7c%7]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 20:28:48 +0000
Subject: Re: runqslower build failed on Debian9
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>
CC:     <linux-kselftest@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <60b05d23-6352-b978-3bf7-5a86466bb297@cn.fujitsu.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <c1025a74-1d80-5127-2b0a-87465d3dbcd0@fb.com>
Date:   Thu, 26 Mar 2020 13:28:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <60b05d23-6352-b978-3bf7-5a86466bb297@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:300:81::16) To MW3PR15MB3753.namprd15.prod.outlook.com
 (2603:10b6:303:50::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:51:fde8:f2bb:1332] (2620:10d:c090:400::5:7bf1) by MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:28:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:7bf1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea4a4a37-6ec2-4fa8-b39d-08d7d1c449dd
X-MS-TrafficTypeDiagnostic: MW3PR15MB3753:
X-Microsoft-Antispam-PRVS: <MW3PR15MB3753D474929BBC55650E6B0FC6CF0@MW3PR15MB3753.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(81156014)(16526019)(36756003)(186003)(316002)(31696002)(8676002)(6916009)(86362001)(52116002)(81166006)(6486002)(4326008)(2906002)(31686004)(478600001)(2616005)(8936002)(53546011)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3753;H:MW3PR15MB3753.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XO6P8dOovh8g0KbfCG3K/JlVe4f1vZQs190OU30LrNRlGj7YBmLYkhEAaNFc0zLXdxV8uYmVRol0iUaPyyp//aZUfpRTm08RYTtiFu3+bUPapB2omFXW1SfSKyaylFY8+M86w8KYDjGv4d5n7OTAtg6rUOZq0mEH3trdqSvR3+Gm3061riHa7X3nNDMHhFwXDKJ6GYqUsx6DgUypXOU+bYG6CPvNCY5N7BwkYy4raV+ks2Pb3kXC7bT/nnnV2ArMXzOtk050/5v2bD2h6D1oGnyrdWrm6amNVmYQ4H7MJuLsuNBZjtgA7rNvJEVt67Vc2tgtYji9uP2L0b+32YFcYUHNwLVzpPIMY8oTuCQ7WhM/skxxIHl+7mZvjRcaByG/I+FR0RzZ2zoY8Wljida4teapz5abevdyClWPKw5xlN82l+KHjpFYBH98oOGRK4h
X-MS-Exchange-AntiSpam-MessageData: BrfwHdDS7Nn5VzjttTZShs6CzB23o3bmQZg+zuJN5/44FKXcI2PsfHBqyEHNPeKvhbZX8MN32mpYba98SXX0DBkbsSxqcASNvcv16mC2GxN7gJHgLOZwg5grhbhdrasNUBQ2ppnr0HadOM6NtmquwKTosteVV7IEn3sjwdMVntytk+gfxXS0Tv91UpLE4kwn
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a4a37-6ec2-4fa8-b39d-08d7d1c449dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:28:48.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD5d0QoHrFbyVWb21Km9phlvIUqq7uPOYPVswPB5zcgWhecspu+UuZshavHrjpTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3753
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_12:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260147
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/20 10:26 PM, Liu Yiding wrote:
> Hi, Andrii.
> 
> I noticed you had added runqslower tool to tools/bpf, so drop this 
> problem to you.
> 
> 
> Now i failed to run bpf tests since i can't build runqslower.
> 
> Testing env: "Debian GNU/Linux 9 (stretch)"
> 
> kernel: 5.6.0-rc5
> 
> gcc: gcc 6.3
> 
> clang: clang-11.
> 
> 
> Description: Build runqslower failed due to build error "incomplete 
> type" and libbpf show unsupported BTF_KIND:7.
> 
> Whole build log please see the attatchment.
> 
> 
> Error info
> 
> ```
> 
> root@vm-snb-144 ~/linus/tools/bpf# make
> 
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ OFF ]
> 
> [snip]
> 
>    INSTALL  bpftool
>    LINK     bpf_asm
>    GEN      vmlinux.h
> libbpf: unsupported BTF_KIND:7    (Many unsupported errors)
> libbpf: unsupported BTF_KIND:7
> libbpf: unsupported BTF_KIND:7
> 

Would you be able to share BTF of vmlinux that is used to generate 
vmlinux.h? Please run in verbose mode: `make V=1` and search for 
`bpftool btf dump file` command. It should point either to
/sys/kernel/btf/vmlinux or some other location, depending on how things 
are set up on your side.

If it's /sys/kernel/btf/vmlinux, you can just `cat 
/sys/kernel/btf/vmlinux > my_btf.bin`. If it's some other file, easiest 
would be to just share that file. If not, it's possible to extract .BTF 
ELF section, let me know if you need help with that.


> [snip]
> 
> (Many incomplete type errors)
> 
> .output/vmlinux.h:8401:18: error: field has incomplete type 'struct 
> idt_bits'
>          struct idt_bits bits;
>                          ^
> .output/vmlinux.h:8396:8: note: forward declaration of 'struct idt_bits'
> struct idt_bits;
>         ^
> .output/vmlinux.h:8598:21: error: field has incomplete type 'struct 
> trace_entry'
>          struct trace_entry ent;
>                             ^
> .output/vmlinux.h:8595:8: note: forward declaration of 'struct trace_entry'
> struct trace_entry;
>         ^
> .output/vmlinux.h:9006:25: error: array has incomplete element type 
> 'struct cyc2ns_data'
>          struct cyc2ns_data data[2];
>                                 ^
> .output/vmlinux.h:3669:8: note: forward declaration of 'struct cyc2ns_data'
> struct cyc2ns_data;
>         ^
> fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 20 errors generated.
> Makefile:56: recipe for target '.output/runqslower.bpf.o' failed
> make[1]: *** [.output/runqslower.bpf.o] Error 1
> Makefile:119: recipe for target 'runqslower' failed
> make: *** [runqslower] Error 2
> 
> ```
> 
> 

