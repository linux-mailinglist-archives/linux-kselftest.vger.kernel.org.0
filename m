Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BA5F5A83
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJETRM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJETRL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 15:17:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308913F68;
        Wed,  5 Oct 2022 12:17:06 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295J4kaW010737;
        Wed, 5 Oct 2022 19:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=E8ePKIa98iVONEUZny1Gqy0ELAIf6a02zctey4g5Hfg=;
 b=B826LO+hllWUOwTXlZcVCjpwz9qVKABVW3DBmiW6vkmbn8bYpkMB9RPsNFQK7qklA8iB
 Oyqs26wjKG1UbFWVs06Nl+1i0DTckgQd/e6aw9gjUwndmKf1JPlJHl/eTSgFjtIOoZvn
 m793mobhX/wITZyYO7cpgnurU1jsJg6VCka1b7wxMPoiNpVuw8+oV9rwRyPT51xqDMNj
 650zgOWCEHOUbr/BTiLSkXzZDV438M57T2gb7YAS9U9PT/eSQmZiNj7GbbbWtwlmMvxA
 EO64ao6Rwt9BEp/k/6qpSJ+eHlpEp0/lPdieIEjhmuQs3i6d8bqGLZHplPf+f6je2V2A mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1fs2r9v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 19:16:55 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 295J4k8W010746;
        Wed, 5 Oct 2022 19:16:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1fs2r9ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 19:16:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 295J5N5R016797;
        Wed, 5 Oct 2022 19:16:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3jxd68vcdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 19:16:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 295JCIrB46727446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 19:12:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7032DA4051;
        Wed,  5 Oct 2022 19:16:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26256A4040;
        Wed,  5 Oct 2022 19:16:45 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.56.127])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Oct 2022 19:16:45 +0000 (GMT)
Message-ID: <730ad052651fc393b18c7f5664788fb66719b970.camel@linux.ibm.com>
Subject: Re: [PATCH v1 2/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Wed, 05 Oct 2022 21:16:43 +0200
In-Reply-To: <37197cfe-d109-332f-089b-266d7e8e23f8@redhat.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
         <20220930210751.225873-3-scgl@linux.ibm.com>
         <37197cfe-d109-332f-089b-266d7e8e23f8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dI4glRReVo79bjt7WRwpkeV2XRY1dYI6
X-Proofpoint-ORIG-GUID: 7U8shb_UzHkEW4OF4lqyth2MGUMsiqw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=884 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-10-05 at 08:32 +0200, Thomas Huth wrote:
> On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> > User space can use the MEM_OP ioctl to make storage key checked reads
> > and writes to the guest, however, it has no way of performing atomic,
> > key checked, accesses to the guest.
> > Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> > mode. For now, support this mode for absolute accesses only.
> > 
> > This mode can be use, for example, to set the device-state-change
> > indicator and the adapter-local-summary indicator atomically.
> > 
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> > 
> > 
> > The return value of MEM_OP is:
> >    0 on success,
> >    < 0 on generic error (e.g. -EFAULT or -ENOMEM),
> >    > 0 if an exception occurred while walking the page tables
> > A cmpxchg failing because the old value doesn't match is neither an
> > error nor an exception, so the question is how best to signal that
> > condition. This is not strictly necessary since user space can compare
> > the value of old after the MEM_OP with the value it set. If they're
> > different the cmpxchg failed. It might be a better user interface if
> > there is an easier way to see if the cmpxchg failed.
> > This patch sets the cmpxchg flag bit to 0 on a successful cmpxchg.
> > This way you can compare against a constant instead of the old old
> > value.
> > This has the disadvantage of being a bit weird, other suggestions
> > welcome.
> 
> This also breaks the old API of defining the ioctl as _IOW only ... with 
> your change to the flags field, it effectively gets IOWR instead.

Oh, right.
> 
> Maybe it would be better to put all the new logic into a new struct and only 
> pass a pointer to that struct in kvm_s390_mem_op, so that the ioctl stays 
> IOW ? ... or maybe even introduce a completely new ioctl for this 
> functionality instead?

Hmmm, the latter seems a bit ugly since there is so much commonality
with the existing memop. 
> 
>   Thomas
> 

