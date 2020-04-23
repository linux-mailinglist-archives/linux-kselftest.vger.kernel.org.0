Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D21B6629
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Apr 2020 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDWVcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Apr 2020 17:32:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23858 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgDWVcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Apr 2020 17:32:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NLUFcW013800;
        Thu, 23 Apr 2020 14:32:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=14+AeppZfzF74Dkyextu+P05LH7j/DH9aOiVAZ4egn4=;
 b=ohui63MM97I5ocZgfVzY7h2tkyGN3s8nxD/ZB04i7vmQm2OGyG+W1KeJarlUnkzk30WS
 NcuUD9aZphdMxJz+ab+jCBCddjKbykDaXJqGBMyYbzdIz4BmPl06iI7R9TJ4cbboaUwb
 fnlc39sGJupPmZ6ZIh/a/ZmmV8ypX1qHiOQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30jtc5r8xg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Apr 2020 14:32:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 23 Apr 2020 14:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Kawqbe3ZEoziSvk3Xjb7olOurMCsgp1Mq0syhdioKs35qFqYBpAcUyMLBOgJJs3oNfJOuKkVbTCIiplbg2sPfAYaO5zziUS0S5hmejv+Qq3T8KRTauslJ4vrydvmY4U9lbU7bcbW2NlDf7VDCPQ2FWQLEK6yvfbqdAldFSXSkn4TETSyeOVSj/mywCVEV3a94cBhQZEZ6pq3dLQw+r6NX5ka3+N3Tl1YS3N9hLjLj+5E+/aQhRUhMwSqcN/iptlhh0whvED1y/ANzb2ozl5hdqzPX4Z+uk1UVzGXp26RHoKbGAsfKf3gYVx4xy78aE/E2ePgiEI/BEGr4MUavOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14+AeppZfzF74Dkyextu+P05LH7j/DH9aOiVAZ4egn4=;
 b=PwK5iTvXw8yjHG4W3wB6UjAImIqURe1Fs5b7RXef8nxk6sPTivfCJxgEZRAswu3DwEt86xGE8bHZHyq5EHP7CVHkSnDdGf1D8qb8QLwWJxopZ7DCq9744SgwEXIG154FZ0799R8fmY+9wtxvwjIzhovoBvyHM2YydfeWX0YGVkv+YqqEM5HSMK6VWzkSnTdTAXzfR3r69BQpjc7g9RBcuh2ZWoQUM7gv+YyrWaFv+rywWrH7oQCkd4wcHaTUmdxeP+AqO7hhcfvqKtEchAHR2ocm9P+GpSyimkmmEa3V6Cs+EqhQ70Aqko75NdV9QQUGuKkP/V08eKFwFBT72dtaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14+AeppZfzF74Dkyextu+P05LH7j/DH9aOiVAZ4egn4=;
 b=YS8eV4aWsHxWVBD5Rq7ULai3iPi4+Mv//foNykFyMVJj110zp7oiZLQ0cqQywlX23SgSArVG4VNm3YNNAmz/87wvsOseF17EjPn4RbiLBJ7AWasaXSC9CWtTGkayunCgpXULFmjvrSZxxZyJAbsCKjW79IbzorcAPB5joxidspU=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2693.namprd15.prod.outlook.com (2603:10b6:a03:155::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 21:32:01 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 21:32:01 +0000
Date:   Thu, 23 Apr 2020 14:31:58 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Ma Xinjian <max.xinjian@intel.com>
CC:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Philip Li <philip.li@intel.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>
Subject: Re: bpf: test_sysctl run failed on Debian9
Message-ID: <20200423213158.GA37107@rdna-mbp>
References: <cc5c7dcb-02ab-3ea5-2330-7678abeb43b4@intel.com>
 <079fd1a6-fd66-e997-9c03-6529489aad54@intel.com>
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <079fd1a6-fd66-e997-9c03-6529489aad54@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:9635) by MWHPR2001CA0004.namprd20.prod.outlook.com (2603:10b6:301:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 21:32:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:9635]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449cf6de-2c1f-49bf-9247-08d7e7cdc259
X-MS-TrafficTypeDiagnostic: BYAPR15MB2693:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26933D346173BE1963B89A4EA8D30@BYAPR15MB2693.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(7916004)(366004)(44144004)(33716001)(66616009)(54906003)(2906002)(1076003)(5660300002)(6916009)(66946007)(6486002)(235185007)(52116002)(6496006)(66476007)(4326008)(16526019)(33656002)(33964004)(8676002)(9686003)(81156014)(186003)(498600001)(66556008)(8936002)(86362001)(2700100001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHmVxwca7JzCKAQ2flqlnhQZG9GBxweMYnpgJQdmcVKX+Jc8K1uHM9nYOfDDVcmAOh9//h8jVUJBe9lqjaQxp1gfLL13GJYpWP5N+1lqH8L5m/pik7OeN1xCyUiw7d2sOVhMlE6iH6Krg7wzqh2++4vWWW+rdfn4GxaIQT674QTuvnVFDbG4CMcOB0mmcYJBOCqDka6pWti/VuLcLm04lN1WPLyL/GdXmwgDj+C7xVk0nvzIeg1WCHdqzSaYTzQrudMZZbVnnrs7xRbOiM78vWSWpNWsWYw+wUOrpt38/TrgcKq2BLxYvshRj5y/PafuzqOvbSE8xFzOXfXii30mo9UidsosdnOPhh8A2+YMtGP9nseBEdW82BoUSo823OYF6Sl4GX8dEfyRlPjkMG9fTw1NUHEbqhFcdnVbOvDniaTqg5Z6qeqMHmkpOZTzRVAEDJh4CH9vLGsMyaY35mP5kRQ+GWDSopibpYTQj2FVkE+Cy3EuPdUe/33JdF7UDI69
X-MS-Exchange-AntiSpam-MessageData: zSNCkDUxGsA0dnhsV+ias5l/by224+fb5awZw8iboiWVF1xYh5l+kKB+rGKN5dUZzb+avkPse0cMuuHZmnYyva9bFmvKuBMg+4N1s2oVwMDdhc9XSZZQg9nOEqijfhNvlKYFxdY/FIIhDS+Hxm0qqvSGIqNKpvARvqKy5WXbf1UzUgquxsV39+NxvYeSLwWG
X-MS-Exchange-CrossTenant-Network-Message-Id: 449cf6de-2c1f-49bf-9247-08d7e7cdc259
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 21:32:01.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 795/wqG4/nIDqvrPgFwlTaGakNBzQjN9iNAUlb5VZ06+oICuaAFa9NuSmHWfsMOd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2693
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_16:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230153
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Ma Xinjian <max.xinjian@intel.com> [Thu, 2020-04-23 02:12 -0700]:
> Hi,  Andrey.
> 
> I noticed you add test_sysctl to tools/bpf, so drop this problem to you.
> 
> When I run selftests: bpf: test_sysctl, failed with "(test_sysctl.c:1490:
> errno: Permission denied) >>> Loading program (./test_sysctl_prog.o) error."
> 
> 
> Testing env: "Debian GNU/Linux 9 (stretch)"
> 
> kernel: 5.7.0-rc2    5.7.0-rc1  5.6  both failed
> 
> 
> Whole run log and kconfig please see the attatchment.
> 
> Error info
> 
> ```
> 
> root@vm-snb-42 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-ae83d0b416db002fe95601e7f97f64b59514d936/tools/testing/selftests/bpf#
> ./test_sysctl
> 
> Test case: sysctl wrong attach_type .. [PASS]
> Test case: sysctl:read allow all .. [PASS]
> Test case: sysctl:read deny all .. [PASS]
> 
> [snip]
> 
> libbpf: -- END LOG --
> libbpf: failed to load program 'cgroup/sysctl'
> libbpf: failed to load object './test_sysctl_prog.o'
> (test_sysctl.c:1490: errno: Permission denied) >>> Loading program
> (./test_sysctl_prog.o) error.
> 
> Test case: C prog: read tcp_mem .. [FAIL]
> Summary: 37 PASSED, 3 FAILED

Hi Ma,

I can not reproduce it. I built 5.7.0-rc2 with your config (with minor
changes to just make it work with my qemu-setup, specifically
CONFIG_EXT4_FS=y), built tests and run it, no failures:

	root@arch-fb-vm1:/home/rdna/bpf-next/tools/testing/selftests/bpf uname -srm
	Linux 5.7.0-rc2 x86_64
	root@arch-fb-vm1:/home/rdna/bpf-next/tools/testing/selftests/bpf ./test_sysctl
	...
	Test case: C prog: deny all writes .. [PASS]
	Test case: C prog: deny access by name .. [PASS]
	Test case: C prog: read tcp_mem .. [PASS]
	Summary: 40 PASSED, 0 FAILED

Thouhg I see that test_sysctl_prog.o program I have differs from what
you have. I attach test_sysctl_prog_xlated.gz with my program.

Specifically the difference starts after the first call to bpf_strtoul.

The code from my prog looks like this (from the first call to
bpf_strtoul to the second call to bpf_strtoul):

	  71: (85) call bpf_strtoul#110448
	  72: (bc) w7 = w0
	; if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
	  73: (bc) w1 = w7
	  74: (04) w1 += -1
	  75: (26) if w1 > 0xe goto pc-21
	; off += ret & MAX_ULONG_STR_LEN;
	  76: (54) w7 &= 15
	  77: (bf) r1 = r10
	  78: (07) r1 += -64
	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
	  79: (0f) r1 += r7
	; tcp_mem + i);
	  80: (bf) r4 = r10
	  81: (07) r4 += -80
	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
	  82: (b7) r2 = 15
	  83: (b7) r3 = 0
	  84: (85) call bpf_strtoul#110448

It can be seen that r1 points to stack-64 + r7 that is known to be <15.

This is basically `value + (ret & MAX_ULONG_STR_LEN)` from the C code.

The code from your version of program looks like this:

	  70: (85) call bpf_strtoul#106
	last_idx 70 first_idx 63
	regs=4 stack=0 before 69: (b7) r3 = 0
	regs=4 stack=0 before 68: (b7) r2 = 15
	  71: (bc) w7 = w0
	; if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
	  72: (bc) w1 = w7
	  73: (04) w1 += -1
	  74: (26) if w1 > 0xe goto pc+14
	 R0=inv(id=0) R1_w=inv(id=0,umax_value=14,var_off=(0x0; 0xf)) R6=inv0 R7_w=inv(id=0,smax_value=2147483647,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=00000000 fp-80=00000000 fp-88=mmmmmmmm
	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
	  75: (bc) w2 = w7
	  76: (67) r2 <<= 32
	  77: (77) r2 >>= 32
	  78: (bf) r1 = r10
	;
	  79: (07) r1 += -64
	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
	  80: (0f) r1 += r2
	last_idx 80 first_idx 71
	regs=4 stack=0 before 79: (07) r1 += -64
	regs=4 stack=0 before 78: (bf) r1 = r10
	regs=4 stack=0 before 77: (77) r2 >>= 32
	regs=4 stack=0 before 76: (67) r2 <<= 32
	regs=4 stack=0 before 75: (bc) w2 = w7
	regs=80 stack=0 before 74: (26) if w1 > 0xe goto pc+14
	regs=80 stack=0 before 73: (04) w1 += -1
	regs=80 stack=0 before 72: (bc) w1 = w7
	regs=80 stack=0 before 71: (bc) w7 = w0
	 R0_rw=invP(id=0) R6=inv0 R7=ctx(id=0,off=0,imm=0) R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm fp-56=mmmmmmmm fp-64=mmmmmmmm fp-72=00000000 fp-80=00000000 fp-88=mmmmmmmm
	parent didn't have regs=1 stack=0 marks
	last_idx 70 first_idx 63
	regs=1 stack=0 before 70: (85) call bpf_strtoul#106
	; tcp_mem + i);
	  81: (bf) r4 = r10
	  82: (07) r4 += -80
	; ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
	  83: (b7) r2 = 15
	  84: (b7) r3 = 0
	  85: (85) call bpf_strtoul#106
	R1 unbounded indirect variable offset stack access
	processed 88 insns (limit 1000000) max_states_per_insn 0 total_states 7 peak_states 7 mark_read 6

In this case r1 points to stack-64 + r2 and it seems to me that the
state of r2 is the problem, but I don't undesrtand why.

32LSB of r2 seems to be known because:
	  71: (bc) w7 = w0
	  72: (bc) w1 = w7
	  73: (04) w1 += -1
	  74: (26) if w1 > 0xe goto pc+14
	  75: (bc) w2 = w7

and 32MSB of r2 are cleared because:
	  76: (67) r2 <<= 32
	  77: (77) r2 >>= 32

So it seems to me that r2 has to be known and in (0x0; 0xf) range.

To summarize:

* I see that your program differs what may mean you have different
  environemnt where you build BPF proga (e.g. different clang/llvm
  version), FWIW I have clang version 9.0.20190721 (though it's heavily
  patched facebook version).

* I'm not quite sure why verifier rejects your version of the program --
  here we would need more eyes. I'm cc'ing Alexei and Daniel.


-- 
Andrey Ignatov

--RnlQjJ0d97Da+TV1
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="test_sysctl_prog_xlated.gz"
Content-Transfer-Encoding: base64

H4sICBn8oV4AA3Rlc3Rfc3lzY3RsX3Byb2dfeGxhdGVkAK2YbW/bNhDH3+dTsCgQWElckxSflNbB
+qLom6wDtnUYUASGY8upAMcKJLnJtva7746WRNmiPK4pkCDx6Xj8391P9ElFnlc/zYvF5/Hqdvzl
nl1OPuf36aRYbuaT24fVeJM+VZMqz9flpErLKtvcTcp0vcL/S3Qgr15Ndj/wAX/Rt/lLHsiSPK3n
Vbok2ZIwQU+yTUXKv8pFtZ5Vi4fZfXo/Kqtiu6gIrJntrpAzsqieosuT1yTMHb1PCCH0koxuVxEp
NJmSgqGJoUmDiYGJQsTtpszuNiBonW/uSB30U3wDl/+hFwR/vr3GlRxW6tuInI22SpCzaFQwSsaa
R23s2OthqPMQfg/jPCTqExF5VLW+bEVGkM/46rHIqtSmpcBHMciBgw+EirkNpcm55JF/iYYlUkV4
6ZGTFxD6iZK7vMrJw+JcaFgEWZdpNdrM71ObdZn9neYr+zmKbAGMX7zTnngdmGo9GPV6cOE8mNcj
dlVm/j4IV2Xm74NwSpm/D7KjVHo9VEepauDi1gS9QisWmmprPZ/iAihtkVbg4gCd3aXVDAuLXbog
u5J36w0NsCVnptkDaS00mpIG4BhMEB7ApI1JWGbAglU0MiKL+Xrt2/glS6SiDV6o7w2h5OtXKxXo
qMXUd4NdEpExYcgS5x2W6I4l5mCKOfrYFrBaONTQdEuIDqIThO2CqNQFaaThzp+yG3ToigGTjSKH
t4mjsBDKI0S2QrgJi6KHhfBAIaYvRAsnRIVFSYaFsDAhMe0L4SsnRIRFYcNCaKAQ7mlN4oTwsCjD
KMokUIgHVu2I52GwxsOwShMoxAOrVq0QFgZrPAyr1IFCPLDGDlYWBms8DCvEDgohjsPKwmAVw7BK
GSjEA2vn9mVhsIojsIpAIb6TNXZCwmAVR2ANPFmFD1Z314SxKo6wGniwCg+r0iEShqo4gmrguSo9
qKqlG8LCghwhNfBYlb5jtfONFxZkGFQReKpKBJW1OqYH9UAd39DNTsSLCGeNKYzFaEKyEhhv0qes
CttrGCPRnr0vsrJ9qMAnCLvQA0/L8BinL5n05kD/wLfYFkW6qWZf5uttPfnZfy/Iz2//nP3x9vrj
u9lvv/86u373wQ5/ivZGSTCy3kSoeG8iVPGR+W9PBwyCQtHmXjwYBK+mHmkYHjvH2wnwCg//9oYa
M5xAldzTWU/HSjUpsU5KunEVtSvYTOMorKMx+1Wtiirfrkc2BXJO8tVqV8WP1798eN9IxccYjNVO
zNggJsGkabdkuKHuT8y7PV4yRoUw6MIbEPFp8nFveJ52itYXgjXTcbMaC/KIjdNYRiqsCZPEpwot
O6VltrTtVDzmDPaEXNEbtzrtb4VV1vbgFVboaZOxPuwH2EyvG99dZI1FpqsmVoFPlPW9BEszC7Sh
/UYbdtBo+v0aDO812sSHjTbiPxr9v7pq5F5X7Qaq31Wjj3Q1joO6akzTVVp3NWiV7cvu9DyvuUto
794MiJSwH0dLwvdpoR5akrhPSyL2adH8GRpkj5ZEHdKS6B9JS2IaNGiLRpL0zlKHhpC7/LbFpn0z
RW/giG4+sBtyetr95C7xG6gio/aNS+K++PZfTD07PGvC83548/zwyMl8aYsDO7zBLNpBFq8jIxTa
0xYsQavovkNjzxYhh3PU/Pk5qk6ODHPkbTqSo4PefyUIFnOQthQn/wI7P/iHuBUAAA==

--RnlQjJ0d97Da+TV1--
