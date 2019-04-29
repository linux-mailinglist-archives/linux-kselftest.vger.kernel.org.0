Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1708E5C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfD2PGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:06:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbfD2PGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:06:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TF3Tu3012494;
        Mon, 29 Apr 2019 11:06:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s61cbed3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Apr 2019 11:06:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x3T98ihd024274;
        Mon, 29 Apr 2019 09:09:54 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3r2et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Apr 2019 09:09:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3TF61IC36503660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 15:06:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C4FDB2077;
        Mon, 29 Apr 2019 15:06:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F49B206B;
        Mon, 29 Apr 2019 15:06:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.213.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Apr 2019 15:06:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D035316C0A0D; Mon, 29 Apr 2019 08:06:00 -0700 (PDT)
Date:   Mon, 29 Apr 2019 08:06:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190429150600.GA14389@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
 <20190424183039.GA4494@linux.ibm.com>
 <20190425194638.GA7238@linux.ibm.com>
 <20190426105413.rajcon4vyzov446c@linutronix.de>
 <20190426135058.GD3923@linux.ibm.com>
 <20190429081943.gucbalncrrttxxcr@linutronix.de>
 <20190429144924.GP3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190429144924.GP3923@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290106
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 07:49:24AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 29, 2019 at 10:19:44AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-04-26 06:50:58 [-0700], Paul E. McKenney wrote:
> > > One place to look is in the summary output:
> > > 
> > > TREE01 ------- 17540 GPs (58.4667/s) [rcu: g130629 f0x0 ]
> > > 
> > > The "58.4667/s" is the number of grace periods per second.  I would be
> > > surprised if CONFIG_PARAVIRT_SPINLOCKS made a noticeable difference in
> > > grace-period rate (given the natural variation), but you never know.
> > 
> > I did four runs of the different parts of the patch:
> > - 5.1-rc6
> > - #1 + kvm64 CPU + some config options
> > - #2 + tsc-deadline=on and so on (the whole line)
> > - #3 + CONFIG_PARAVIRT_SPINLOCKS (now everything)
> > 
> > the test command was
> > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 112 --duration 60 --configs "16*TREE08" --memory 4G
> > 
> > and the results:
> > | HEAD is now at 085b7755808a... Linux 5.1-rc6
> > | (28.5942 +27.4658 +28.0203 +27.2061 +28.0731 +26.9078 +27.8494 + 27.3392 +26.4339 +28.025 +27.4797 +27.6775 +28.0653 +28.0742 +27.9581 +28.6508)/ 16
> > | 27.738775
> > | 
> > | HEAD is now at 36a12aa9761a... tune #1
> > | (28.5761 +26.6514 +26.6989 +27.4375 +27.3442 +28.3228 +26.6353 +27.5461+28.5531 +27.7006 +27.8078 +27.9753 +27.4269 +28.0464 +27.6314 +27.8356) / 16
> > | 27.6368375
> > | 
> > | HEAD is now at af5cd7196436... tune #2
> > | (28.4867 +26.3675 +27.6364 +28.3344 +27.4153 +27.9306 +27.1703 +26.8461+27.3194 +28.5486 +27.8975 +27.4356 +28.12 +28.4397 +29.0186 +26.9328 )/ 16
> > | 27.74371875
> > | 
> > | HEAD is now at 3701f64943f5... tune #3
> > | (28.2431 +27.7831 +28.39 +28.2586 +27.7408 +27.9258 +26.6236 +26.7817+29.1178 +26.9564 +29.0525 +27.4258 +27.4931 +27.8928 +26.9308 +28.4833)/ 16
> > | 27.8187
> > 
> > This 28.… is the number of GP/s. Based on the results in looks like
> > noise to me. Also I have no idea why you have more than twice as many
> > GP/s as I do.
> 
> My guess is that because you have more CPUs, the for_each_online_cpu()
> loop takes longer on your system.

OK, that is rather oversimplified, to say the least.  A better way to
put this is that the probability of some CPU holding things up is larger
the more CPUs you have.  RCU doe take explicit steps to slow down grace
periods, but that doesn't start kicking in until 256 CPUs.

							Thanx, Paul

> > Different box doing:
> > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 112 --duration 60 --configs "42*TREE01" --memory 4G
> > and got this:
> > 
> > | HEAD is now at 085b7755808aa... Linux 5.1-rc6
> > | (15.2878 + 15.8664 + 15.6369 + 15.6714 + 15.3667 + 16.4706 + 15.7844 +
> > | 16.2119 + 15.6108 + 15.84 + 16.0003 + 16.2886 + 15.8728 + 15.5347 +
> > | 15.6753 + 15.6628 + 15.8628 + 15.8158 + 15.8419 + 16.0053 + 15.7878 +
> > | 16.465 + 16.2267 + 16.6881 + 16.3186 + 16.1778 + 15.7069 + 16.0178 +
> > | 15.7156 + 16.0083 + 15.7181 + 15.8961 + 15.5253 + 16.1569 + 15.7692 +
> > | 16.2622 + 16.2931 + 15.9531 + 15.6697 + 15.4539 + 15.6478 + 15.8047) /
> > | 42
> > |	~15.89452142857142857143
> > |
> > | HEAD is now at 3701f64943f5a... tune #3
> > | ; (15.8461 + 15.8653 + 16.0392 + 15.8906 + 15.7606 + 15.6169 + 16.1425 +
> > | 15.9089 + 16.2169 + 16.1694 + 16.2122 + 15.6417 + 15.8022 + 16.1178 +
> > | 15.1689 + 16.1303 + 16.0181 + 16.3797 + 16.0614 + 16.2839 + 15.4583 +
> > | 15.9178 + 16.0589 + 16.3428 + 15.5486 + 16.0839 + 15.9931 + 15.8417 +
> > | 16.0981 + 15.8075 + 15.9925 + 15.7311 + 15.9172 + 16.1164 + 15.6303 +
> > | 15.9383 + 16.0714 + 16.2786 + 15.8394 + 15.9597 + 16.0175 + 15.3908) /
> > | 42
> > |	~15.93586904761904761905
> > 
> > Noise.
> > 
> > So from RCUtorture point of view there is no improvement right? In that
> > case I would suggest to drop the problematic parts…
> 
> Thank you for testing this!  I will adjust accordingly.
> 
> 							Thanx, Paul
